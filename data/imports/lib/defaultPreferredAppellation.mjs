/**
 * Optional regnal fallback for import generators.
 * Runtime ignores non-regnal preferred values; see emperorAppellation.ts.
 */

/** @returns {{ kind: "regnal", name: string }} */
export function defaultPreferredAppellation({ title }) {
  return { kind: "regnal", name: title };
}
