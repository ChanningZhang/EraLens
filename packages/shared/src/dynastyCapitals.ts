import type { CapitalRole, CapitalLocation, EntityRef, Reign } from "./schema";
import { isParallelClaim } from "./claimTracks";
import { isUncertainDateConfidence } from "./reignBoundaries";
import { formatReignDurationLabel } from "./reignVisual";
import { confidencePrecision, formatHistoricalDate, hasUncertainDateRange } from "./historicalDate";
import {
  effectiveIntervalEndPoint,
  effectiveIntervalStartAbs,
  effectiveIntervalStartPoint,
} from "./timelineIntervals";
import {
  activeCapitalsAtAbs,
  capitalSegmentsForReign,
} from "./timelineOwnership";

type CapitalTimePoint = { year: number; month: number; day?: number };

export const CAPITAL_ROLE_LABEL: Record<CapitalRole, string> = {
  primary: "正都",
  secondary: "陪都",
  temporary: "临时都城",
};

const CAPITAL_ROLE_ORDER: Record<CapitalRole, number> = {
  primary: 0,
  secondary: 1,
  temporary: 2,
};

export function capitalRoleLabel(role: CapitalRole, claimTrack?: string | null): string {
  // A primary seat belongs to its own claimant, not to the dynasty's main court.
  if (role === "primary" && isParallelClaim({ claimTrack: claimTrack ?? undefined })) {
    return "并立政权治所";
  }
  return CAPITAL_ROLE_LABEL[role];
}

/** Dynasty mappings do not claim that a primary seat belonged to the whole dynasty. */
export function capitalLocationRoleLabel(capital: CapitalLocation): string {
  return capital.mappingKind === "dynasty" && capital.role === "primary"
    ? "主要治所" : capitalRoleLabel(capital.role, capital.claimTrack);
}

/** Capitals whose reign span includes `atAbs` (inclusive on both ends). */
export function capitalsActiveAtAbs(
  capitals: readonly CapitalLocation[],
  atAbs: number,
): CapitalLocation[] {
  return activeCapitalsAtAbs(capitals, atAbs);
}

export type ReignCapitalTenureRow = {
  capital?: {
    ref: EntityRef;
    label: string;
    subtitle?: string;
  };
  tenure: {
    ref: EntityRef;
    label: string;
    abs: number;
    isInformalMonarch?: boolean;
    duration?: string;
  };
};

function formatTenureRangeLabel(
  start: CapitalTimePoint,
  end: CapitalTimePoint,
  startPrecision?: Reign["precision"],
  endPrecision = startPrecision,
  startConfidence?: Reign["start"]["confidence"],
  endConfidence?: Reign["end"]["confidence"],
  isOngoing = false,
): string {
  const formatPoint = (
    point: CapitalTimePoint,
    precision: Reign["precision"] | undefined,
    confidence: Reign["start"]["confidence"] | undefined,
  ): string => formatHistoricalDate({ ...point, confidence: confidence ?? precision ?? "year" });

  const startLabel = formatPoint(start, startPrecision, startConfidence);
  if (isOngoing) return `${startLabel} — 至今`;
  const endLabel = formatPoint(end, endPrecision, endConfidence);
  return startLabel === endLabel && !isUncertainDateConfidence(startConfidence) && !isUncertainDateConfidence(endConfidence)
    ? startLabel
    : `${startLabel} — ${endLabel}`;
}

export function capitalTenureSubtitle(capital: CapitalLocation): string | undefined {
  const role = capitalRoleLabel(capital.role, capital.claimTrack);
  if (capital.role === "primary" && !isParallelClaim(capital)) {
    return capital.modernName;
  }
  return `${role} · ${capital.modernName}`;
}

export function capitalDateRangeLabel(capital: CapitalLocation): string {
  const start = formatHistoricalDate({ ...capital.start, confidence: capital.start.confidence ?? capital.precision ?? "year" });
  const end = formatHistoricalDate({ ...capital.end, confidence: capital.end.confidence ?? capital.endPrecision ?? capital.precision ?? "year" });
  return `${start} — ${end}`;
}

export function dynastyCapitalRelatedItems(
  dynastyId: string,
  capitals: readonly CapitalLocation[],
): Array<{
  ref: EntityRef;
  label: string;
  subtitle: string;
  abs: number;
  group: "location_mapping";
}> {
  return capitals
    .filter((capital) => capital.dynastyId === dynastyId && capital.mappingKind !== "reign")
    .sort(
      (a, b) =>
        a.startAbs - b.startAbs ||
        CAPITAL_ROLE_ORDER[a.role] - CAPITAL_ROLE_ORDER[b.role] ||
        a.historicalName.localeCompare(b.historicalName, "zh-Hans"),
    )
    .map((capital) => ({
      ref: { type: "location_mapping" as const, id: capital.id },
      label: capital.historicalName,
      subtitle: `${capitalDateRangeLabel(capital)} · ${capitalLocationRoleLabel(capital)}`,
      abs: capital.startAbs,
      group: "location_mapping" as const,
    }));
}

/** Pair each overlapping capital with the intersected reign tenure segment. */
export function buildReignCapitalTenures(
  reign: Reign,
  capitals: readonly CapitalLocation[],
  dynastyReigns: readonly Reign[] = [reign],
): ReignCapitalTenureRow[] {
  return capitalSegmentsForReign(reign, dynastyReigns, capitals)
    .map(({ capital, overlapInterval, startsAtReignBoundary, endsAtReignBoundary }) => {
      const startAbs = effectiveIntervalStartAbs(overlapInterval);
      const start = effectiveIntervalStartPoint(overlapInterval);
      const end = effectiveIntervalEndPoint(overlapInterval);
      // Each clipped endpoint inherits the confidence of the boundary that supplied it.
      const startConfidence = startsAtReignBoundary
        ? reign.start.confidence ?? reign.precision ?? "year"
        : capital.start.confidence ?? capital.precision ?? "year";
      const endConfidence = endsAtReignBoundary
        ? reign.end.confidence ?? reign.precision ?? "year"
        : capital.end.confidence ?? capital.endPrecision ?? capital.precision ?? "year";
      const startPrecision = confidencePrecision(startConfidence);
      const endPrecision = confidencePrecision(endConfidence);
      const isOngoing = endsAtReignBoundary && reign.isOngoing;
      const duration = formatReignDurationLabel({
        ...reign,
        start: { ...start, confidence: startConfidence },
        end: { ...end, confidence: endConfidence },
        isOngoing,
      }, overlapInterval);
      return {
        capital: {
          ref: { type: "location_mapping" as const, id: capital.id },
          label: capital.historicalName,
          subtitle: capitalTenureSubtitle(capital),
        },
        tenure: {
          ref: { type: "reign" as const, id: reign.id },
          label: formatTenureRangeLabel(
            start,
            end,
            startPrecision,
            endPrecision,
            startConfidence,
            endConfidence,
            isOngoing,
          ),
          abs: startAbs,
          ...(duration ? { duration } : {}),
          ...(reign.isInformalMonarch ? { isInformalMonarch: true } : {}),
        },
        sortKey: {
          startAbs,
          role: CAPITAL_ROLE_ORDER[capital.role],
        },
      };
    })
    .sort(
      (a, b) =>
        a.sortKey.startAbs - b.sortKey.startAbs ||
        a.sortKey.role - b.sortKey.role ||
        a.capital.label.localeCompare(b.capital.label, "zh-Hans"),
    )
    .map(({ sortKey: _sortKey, ...row }) => row);
}

/** Tenure rows for a reign; falls back to tenure-only when no capitals overlap. */
export function buildReignTenureCapitalRows(
  reign: Reign,
  capitals: readonly CapitalLocation[],
  dynastyReigns: readonly Reign[] = [reign],
): ReignCapitalTenureRow[] {
  if (hasUncertainDateRange(reign)) return [];
  const rows = buildReignCapitalTenures(reign, capitals, dynastyReigns);
  if (rows.length > 0) return rows;
  // The detail row describes the recorded reign span. Ownership clipping is
  // for timeline placement and must not rewrite the tenure's displayed length.
  const duration = formatReignDurationLabel(reign);
  return [
    {
      tenure: {
        ref: { type: "reign", id: reign.id },
        label: formatTenureRangeLabel(
          reign.start,
          reign.end,
          reign.precision,
          reign.precision,
          reign.start.confidence,
          reign.end.confidence,
          reign.isOngoing,
        ),
        abs: reign.startAbs,
        ...(duration ? { duration } : {}),
        ...(reign.isInformalMonarch ? { isInformalMonarch: true } : {}),
      },
    },
  ];
}
