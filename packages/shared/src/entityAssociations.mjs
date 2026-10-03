/** Ordinary associations are unordered pairs. This module also runs in import tooling. */
export const ASSOCIATION_TYPES = ["dynasty", "event", "person"];
const encoder = new TextEncoder();

export function compareEntityRefs(a, b) {
  const aa = encoder.encode(a);
  const bb = encoder.encode(b);
  for (let i = 0; i < Math.min(aa.length, bb.length); i++) {
    if (aa[i] !== bb[i]) return aa[i] - bb[i];
  }
  return aa.length - bb.length;
}

function checkRef(ref) {
  if (typeof ref !== "string" || !/^(dynasty|event|person):[^\u0000]+$/u.test(ref)) {
    throw new Error(`Invalid association endpoint: ${ref}`);
  }
}

export function normalizeAssociation(aRef, bRef) {
  checkRef(aRef);
  checkRef(bRef);
  if (aRef === bRef) throw new Error("Self associations are not allowed");
  return compareEntityRefs(aRef, bRef) < 0 ? { aRef, bRef } : { aRef: bRef, bRef: aRef };
}

export function assertEntityAssociation(row) {
  if (!row || Object.keys(row).length !== 2 || !Object.hasOwn(row, "aRef") || !Object.hasOwn(row, "bRef")) {
    throw new Error("Associations require only aRef and bRef");
  }
  const normalized = normalizeAssociation(row.aRef, row.bRef);
  if (row.aRef !== normalized.aRef) {
    throw new Error(`Association endpoints must be in UTF-8 order: ${row.aRef}, ${row.bRef}`);
  }
  return normalized;
}

export function relatedEntityRefs(associations, ref) {
  return [...new Set(associations.flatMap(row =>
    row.aRef === ref ? [row.bRef] : row.bRef === ref ? [row.aRef] : [],
  ))].sort(compareEntityRefs);
}

export function eventAssociationIds(eventId, associations) {
  const refs = relatedEntityRefs(associations, `event:${eventId}`);
  return {
    dynastyIds: refs.filter(ref => ref.startsWith("dynasty:")).map(ref => ref.slice(8)),
    participantIds: refs.filter(ref => ref.startsWith("person:")).map(ref => ref.slice(7)),
  };
}

export function mapEntityAssociation(row) {
  return assertEntityAssociation({
    aRef: `${row.a_type ?? row.aType}:${row.a_id ?? row.aId}`,
    bRef: `${row.b_type ?? row.bType}:${row.b_id ?? row.bId}`,
  });
}
