/**
 * Abstract multi-reign rules: same person, multiple explicit reign records.
 * Wiki king-lists may merge restoration spans or assign duplicate row indices.
 *
 * Curated span splits live in each import package (cf. chunqiu-zhanguo/build-rulers.mjs),
 * baked into rulers.mjs → import.sql → PostgreSQL. Not a runtime split.
 */

function defaultReignId(personId, dynastyId, ordinal) {
  const base = `reign-${personId}-${dynastyId}`;
  return ordinal > 1 ? `${base}-${ordinal}` : base;
}

function unifyPersonIds(dynastyId, rulers) {
  const nameCounts = new Map();
  for (const r of rulers) {
    const name = r.personName;
    if (!name) continue;
    nameCounts.set(name, (nameCounts.get(name) ?? 0) + 1);
  }

  const firstPersonIdByName = new Map();
  return rulers.map((r) => {
    const name = r.personName;
    if (!name || (nameCounts.get(name) ?? 0) <= 1) return r;
    if (!firstPersonIdByName.has(name)) {
      firstPersonIdByName.set(name, r.personId);
      return r;
    }
    return { ...r, personId: firstPersonIdByName.get(name) };
  });
}

/**
 * @param {Record<string, Record<string, Array<{ startYear: number; endYear: number; ordinal?: number }>>>} spanExpansions
 */
function expandMergedSpans(dynastyId, rulers, spanExpansions) {
  const table = spanExpansions[dynastyId];
  if (!table) return rulers;

  const out = [];
  for (const r of rulers) {
    const expansion = table[r.personName];
    if (
      expansion &&
      r.startYear === expansion[0].startYear &&
      r.endYear === expansion.at(-1).endYear
    ) {
      for (const span of expansion) {
        out.push({
          ...r,
          startYear: span.startYear,
          endYear: span.endYear,
          ...(span.ordinal != null ? { ordinal: span.ordinal } : {}),
        });
      }
      continue;
    }
    out.push(r);
  }
  return out;
}

function assignReignIds(dynastyId, rulers) {
  const byPerson = new Map();
  for (const r of rulers) {
    const list = byPerson.get(r.personId);
    if (list) list.push(r);
    else byPerson.set(r.personId, [r]);
  }

  const out = [];
  for (const list of byPerson.values()) {
    const sorted = [...list].sort(
      (a, b) => a.startYear - b.startYear || a.endYear - b.endYear,
    );
    if (sorted.length === 1) {
      const r = sorted[0];
      out.push({
        ...r,
        reignId: r.reignId ?? defaultReignId(r.personId, dynastyId, 1),
      });
      continue;
    }
    sorted.forEach((r, index) => {
      const ordinal = r.ordinal ?? index + 1;
      out.push({
        ...r,
        ordinal,
        reignId: r.reignId ?? defaultReignId(r.personId, dynastyId, ordinal),
      });
    });
  }
  return out;
}

/**
 * @param {Record<string, Record<string, Array<{ startYear: number; endYear: number; ordinal?: number }>>>} [options.spanExpansions]
 */
export function applyMultiReignRulers(dynastyId, rulers, { spanExpansions = {} } = {}) {
  const unified = unifyPersonIds(dynastyId, rulers);
  const expanded = expandMergedSpans(dynastyId, unified, spanExpansions);
  const withIds = assignReignIds(dynastyId, expanded);
  return withIds.sort(
    (a, b) => a.startYear - b.startYear || a.endYear - b.endYear,
  );
}
