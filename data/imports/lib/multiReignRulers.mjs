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

/** Same given name across centuries is common; only unify when posthumous/title also match. */
function personUnifyKey(r) {
  const name = r.personName;
  if (!name) return null;
  // An unknown-name marker is shared by unrelated rulers and cannot identify
  // one person across multiple source rows.
  if (/^(?:姬)?[？?]$|^缺失$/.test(name)) return null;
  const discriminator = r.posthumousName ?? r.title ?? "";
  return `${name}|${discriminator}`;
}

function unifyPersonIds(dynastyId, rulers) {
  const keyCounts = new Map();
  for (const r of rulers) {
    const key = personUnifyKey(r);
    if (!key) continue;
    keyCounts.set(key, (keyCounts.get(key) ?? 0) + 1);
  }

  const firstPersonIdByKey = new Map();
  return rulers.map((r) => {
    const key = personUnifyKey(r);
    if (!key || (keyCounts.get(key) ?? 0) <= 1) return r;
    if (!firstPersonIdByKey.has(key)) {
      firstPersonIdByKey.set(key, r.personId);
      return r;
    }
    return { ...r, personId: firstPersonIdByKey.get(key) };
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
    // Prefer the stable person name, but allow title-keyed entries when the
    // source omits a personal name and enrichment supplies a clan-prefixed one.
    const expansion = table[r.personName] ?? table[r.title];
    const mergedStart = expansion?.[0]?.startYear;
    const mergedEnd = expansion?.at(-1)?.endYear;
    // Death-year succession normalization may move a merged successor's
    // start one year forward before this split is applied.
    const startMatches = r.startYear === mergedStart || r.startYear === mergedStart + 1;
    if (expansion && startMatches && r.endYear === mergedEnd) {
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
