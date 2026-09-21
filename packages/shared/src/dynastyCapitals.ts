import type { CapitalRole, DynastyCapital, EntityRef, Reign, TimePoint } from "./schema";
import { formatYear, formatYearMonth, rangeIntersectsWindow } from "./time";

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

export function capitalRoleLabel(role: CapitalRole): string {
  return CAPITAL_ROLE_LABEL[role];
}

/** Capitals whose reign span includes `atAbs` (inclusive on both ends). */
export function capitalsActiveAtAbs(
  capitals: readonly DynastyCapital[],
  atAbs: number,
): DynastyCapital[] {
  return capitals.filter((capital) => capital.startAbs <= atAbs && capital.endAbs >= atAbs);
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
  };
};

function segmentTimePoints(
  reign: Reign,
  capital: DynastyCapital,
): { startAbs: number; endAbs: number; start: TimePoint; end: TimePoint } {
  const startAbs = Math.max(reign.startAbs, capital.startAbs);
  const endAbs = Math.min(reign.endAbs, capital.endAbs);
  const start = startAbs === reign.startAbs ? reign.start : capital.start;
  const end = endAbs === reign.endAbs ? reign.end : capital.end;
  return { startAbs, endAbs, start, end };
}

function formatTenureRangeLabel(
  start: TimePoint,
  end: TimePoint,
  precision?: Reign["precision"],
): string {
  if (precision === "month" || precision === "day") {
    const startLabel = formatYearMonth(start.year, start.month, "compact");
    const endLabel = formatYearMonth(end.year, end.month, "compact");
    return startLabel === endLabel ? startLabel : `${startLabel} — ${endLabel}`;
  }
  if (start.year === end.year) {
    return formatYear(start.year, "compact");
  }
  return `${start.year} — ${end.year}`;
}

export function capitalTenureSubtitle(capital: DynastyCapital): string | undefined {
  const role = capitalRoleLabel(capital.role);
  if (capital.role === "primary") {
    return capital.modernName;
  }
  return `${role} · ${capital.modernName}`;
}

export function dynastyCapitalRelatedItems(
  dynastyId: string,
  capitals: readonly DynastyCapital[],
): Array<{
  ref: EntityRef;
  label: string;
  subtitle: string;
  abs: number;
  group: "capital";
}> {
  return capitals
    .filter((capital) => capital.dynastyId === dynastyId)
    .sort(
      (a, b) =>
        a.startAbs - b.startAbs ||
        CAPITAL_ROLE_ORDER[a.role] - CAPITAL_ROLE_ORDER[b.role] ||
        a.historicalName.localeCompare(b.historicalName, "zh-Hans"),
    )
    .map((capital) => ({
      ref: { type: "capital" as const, id: capital.id },
      label: capital.historicalName,
      subtitle: `${capital.start.year} — ${capital.end.year} · ${capitalRoleLabel(capital.role)}`,
      abs: capital.startAbs,
      group: "capital" as const,
    }));
}

/** Pair each overlapping capital with the intersected reign tenure segment. */
export function buildReignCapitalTenures(
  reign: Reign,
  capitals: readonly DynastyCapital[],
): ReignCapitalTenureRow[] {
  return capitals
    .filter(
      (capital) =>
        capital.dynastyId === reign.dynastyId &&
        (capital.claimTrack ?? null) === (reign.claimTrack ?? null) &&
        rangeIntersectsWindow(capital.startAbs, capital.endAbs, reign.startAbs, reign.endAbs),
    )
    .map((capital) => {
      const segment = segmentTimePoints(reign, capital);
      return {
        capital: {
          ref: { type: "capital" as const, id: capital.id },
          label: capital.historicalName,
          subtitle: capitalTenureSubtitle(capital),
        },
        tenure: {
          ref: { type: "reign" as const, id: reign.id },
          label: formatTenureRangeLabel(segment.start, segment.end, reign.precision),
          abs: segment.startAbs,
        },
        sortKey: {
          startAbs: segment.startAbs,
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
  capitals: readonly DynastyCapital[],
): ReignCapitalTenureRow[] {
  const rows = buildReignCapitalTenures(reign, capitals);
  if (rows.length > 0) return rows;
  return [
    {
      tenure: {
        ref: { type: "reign", id: reign.id },
        label: formatTenureRangeLabel(reign.start, reign.end, reign.precision),
        abs: reign.startAbs,
      },
    },
  ];
}
