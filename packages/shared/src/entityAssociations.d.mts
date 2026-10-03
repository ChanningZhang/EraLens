export type EntityAssociation = { aRef: string; bRef: string };
export const ASSOCIATION_TYPES: readonly ["dynasty", "event", "person"];
export function compareEntityRefs(a: string, b: string): number;
export function normalizeAssociation(aRef: string, bRef: string): EntityAssociation;
export function assertEntityAssociation(row: unknown): EntityAssociation;
export function relatedEntityRefs(associations: readonly EntityAssociation[], ref: string): string[];
export function eventAssociationIds(eventId: string, associations: readonly EntityAssociation[]): {dynastyIds: string[]; participantIds: string[]};
export function mapEntityAssociation(row: Record<string, unknown>): EntityAssociation;
