import type { Person } from "./schema";
import { absFromPoint } from "./time";

export type PersonLifeSpan = {
  startAbs: number;
  endAbs: number;
};

/** Requires both birth and death; returns null when lifespan cannot be placed on the axis. */
export function personLifeAbs(person: Person): PersonLifeSpan | null {
  if (!person.birth || !person.death) return null;
  const startAbs = absFromPoint(person.birth);
  const endAbs = absFromPoint(person.death);
  return { startAbs, endAbs: Math.max(startAbs, endAbs) };
}
