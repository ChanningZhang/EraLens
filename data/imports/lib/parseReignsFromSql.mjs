/**
 * Extract reign rows from import.sql INSERT statements for seam validation.
 */

function unquoteSqlString(raw) {
  return raw.replace(/''/g, "'");
}

function parseSqlValue(token) {
  const trimmed = token.trim();
  if (trimmed === "NULL") return null;
  if (/^-?\d+$/.test(trimmed)) return Number(trimmed);
  if (trimmed.startsWith("'") && trimmed.endsWith("'")) {
    return unquoteSqlString(trimmed.slice(1, -1));
  }
  return trimmed;
}

function splitSqlValues(raw) {
  const values = [];
  let current = "";
  let inString = false;
  for (let i = 0; i < raw.length; i += 1) {
    const ch = raw[i];
    if (inString) {
      current += ch;
      if (ch === "'" && raw[i + 1] === "'") {
        current += raw[i + 1];
        i += 1;
        continue;
      }
      if (ch === "'") inString = false;
      continue;
    }
    if (ch === "'") {
      inString = true;
      current += ch;
      continue;
    }
    if (ch === ",") {
      values.push(current);
      current = "";
      continue;
    }
    current += ch;
  }
  if (current.length) values.push(current);
  return values.map(parseSqlValue);
}

function extractInsertBlocks(sql, table) {
  const blocks = [];
  const re = new RegExp(`\\bINSERT\\s+INTO\\s+${table}\\b`, "gi");
  let match;
  while ((match = re.exec(sql)) !== null) {
    const start = match.index;
    const headerEnd = sql.indexOf(")", start);
    if (headerEnd < 0) continue;
    const valuesIdx = sql.indexOf("VALUES", headerEnd);
    if (valuesIdx < 0) continue;
    const openParen = sql.indexOf("(", valuesIdx);
    if (openParen < 0) continue;
    let depth = 0;
    let closeParen = -1;
    for (let i = openParen; i < sql.length; i += 1) {
      const ch = sql[i];
      if (ch === "(") depth += 1;
      else if (ch === ")") {
        depth -= 1;
        if (depth === 0) {
          closeParen = i;
          break;
        }
      }
    }
    if (closeParen < 0) continue;
    const columnsRaw = sql.slice(sql.indexOf("(", start) + 1, headerEnd);
    const valuesRaw = sql.slice(openParen + 1, closeParen);
    blocks.push({
      columns: columnsRaw
        .split(",")
        .map((c) => c.trim())
        .filter(Boolean),
      valuesRaw,
    });
  }
  return blocks;
}

export function parseReignsFromSql(sql) {
  const reigns = [];
  for (const block of extractInsertBlocks(sql, "reigns")) {
    const columnIndex = new Map(block.columns.map((name, index) => [name, index]));
    const values = splitSqlValues(block.valuesRaw);
    const get = (name) => {
      const index = columnIndex.get(name);
      return index == null ? undefined : values[index];
    };
    const id = get("id");
    if (!id) continue;
    reigns.push({
      id,
      dynastyId: get("dynasty_id"),
      personId: get("person_id"),
      startAbs: get("start_abs"),
      endAbs: get("end_abs"),
      startDateConfidence: get("start_date_confidence"),
      endDateConfidence: get("end_date_confidence"),
      claimTrack: get("claim_track") ?? null,
    });
  }
  return reigns;
}
