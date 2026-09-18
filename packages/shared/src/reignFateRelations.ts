import {
  FATE_RELATION_KINDS,
  type FateRelationKind,
  type Reign,
  type Relation,
} from "./schema";

export { FATE_RELATION_KINDS, type FateRelationKind };

export function isFateRelationKind(kind: Relation["kind"]): kind is FateRelationKind {
  return (FATE_RELATION_KINDS as readonly string[]).includes(kind);
}

export function isFateRelation(relation: Relation): relation is Relation & { atAbs: number } {
  return isFateRelationKind(relation.kind) && relation.atAbs != null;
}

export function fateRelationLabel(kind: FateRelationKind): string {
  switch (kind) {
    case "killed":
      return "被杀";
    case "surrender":
      return "投降";
    case "abdication":
      return "禅让";
    case "captured":
      return "被俘";
  }
}

function parsePersonId(ref: string): string | undefined {
  if (!ref.startsWith("person:")) return undefined;
  const id = ref.slice("person:".length);
  return id || undefined;
}

function parseReignId(ref: string): string | undefined {
  if (!ref.startsWith("reign:")) return undefined;
  const id = ref.slice("reign:".length);
  return id || undefined;
}

function reignContainsAbs(reign: Reign, abs: number): boolean {
  return reign.startAbs <= abs && abs <= reign.endAbs;
}

/** Victim side: active reign at atAbs, else latest ended reign with endAbs <= atAbs. */
export function resolveFateFromReign(
  personId: string,
  atAbs: number,
  reigns: readonly Reign[],
): Reign | undefined {
  const matches = reigns.filter((reign) => reign.personId === personId);
  const active = matches.find((reign) => reignContainsAbs(reign, atAbs));
  if (active) return active;

  const ended = matches
    .filter((reign) => reign.endAbs <= atAbs)
    .sort((a, b) => b.endAbs - a.endAbs || b.startAbs - a.startAbs || b.id.localeCompare(a.id));
  return ended[0];
}

const FATE_TO_REIGN_MAX_LAG_MONTHS = 24;

/** Receiver side: reign at atAbs, else next reign within 24 months (禅让/降后即位). */
export function resolveFateToReign(
  personId: string,
  atAbs: number,
  reigns: readonly Reign[],
): Reign | undefined {
  const matches = reigns.filter((reign) => reign.personId === personId);
  const active = matches.find((reign) => reignContainsAbs(reign, atAbs));
  if (active) return active;

  const upcoming = matches
    .filter(
      (reign) =>
        reign.startAbs >= atAbs && reign.startAbs - atAbs <= FATE_TO_REIGN_MAX_LAG_MONTHS,
    )
    .sort((a, b) => a.startAbs - b.startAbs || a.id.localeCompare(b.id));
  return upcoming[0];
}

export type ResolvedFateRelation = {
  relation: Relation & { atAbs: number };
  fromReign: Reign;
  toReign: Reign;
};

const FATE_KINDS_SUPPRESSED_BY_KILLED = new Set<FateRelationKind>([
  "surrender",
  "abdication",
  "captured",
]);

/** Group key for the victim side of a fate line. */
function fateVictimKey(fromReign: Reign): string {
  if (fromReign.personId !== "system-missing-ruler") {
    return `person:${fromReign.personId}`;
  }
  return `reign:${fromReign.id}`;
}

/** When a ruler has both killed and surrender/abdication/captured, keep only killed. */
export function prioritizeKilledFateRelations(
  resolved: readonly ResolvedFateRelation[],
): ResolvedFateRelation[] {
  const killedVictims = new Set<string>();
  for (const item of resolved) {
    if (item.relation.kind === "killed") {
      killedVictims.add(fateVictimKey(item.fromReign));
    }
  }
  if (killedVictims.size === 0) return [...resolved];

  return resolved.filter((item) => {
    if (!FATE_KINDS_SUPPRESSED_BY_KILLED.has(item.relation.kind)) return true;
    return !killedVictims.has(fateVictimKey(item.fromReign));
  });
}

export function resolveFateRelation(
  relation: Relation,
  reigns: readonly Reign[],
): ResolvedFateRelation | undefined {
  if (!isFateRelation(relation)) return undefined;

  const fromReignId = parseReignId(relation.fromRef);
  const fromPersonId = parsePersonId(relation.fromRef);
  const toPersonId = parsePersonId(relation.toRef);
  if ((!fromReignId && !fromPersonId) || !toPersonId) return undefined;

  const fromReign = fromReignId
    ? reigns.find((reign) => reign.id === fromReignId)
    : resolveFateFromReign(fromPersonId!, relation.atAbs, reigns);
  const toReign = resolveFateToReign(toPersonId, relation.atAbs, reigns);
  if (!fromReign || !toReign) return undefined;
  if (fromReign.dynastyId === toReign.dynastyId) return undefined;

  return { relation, fromReign, toReign };
}

export function resolveFateRelations(
  relations: readonly Relation[],
  reigns: readonly Reign[],
): ResolvedFateRelation[] {
  const resolved: ResolvedFateRelation[] = [];
  for (const relation of relations) {
    const item = resolveFateRelation(relation, reigns);
    if (item) resolved.push(item);
  }
  return prioritizeKilledFateRelations(resolved);
}
