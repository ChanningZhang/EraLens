import { readFileSync } from "node:fs";
import path from "node:path";
import { discoverPackages } from "./discoverPackages.mjs";
import { fileURLToPath } from "node:url";

const REIGN_ROW_RE =
  /VALUES\s*\(\s*'(reign-[^']+)',\s*'([^']+)',\s*'([^']+)'[\s\S]*?,\s*(-?\d+),\s*(-?\d+),\s*(NULL|-?\d+),\s*(-?\d+),\s*(-?\d+),\s*(NULL|-?\d+),\s*(-?\d+),\s*(-?\d+),\s*'([^']+)',\s*'([^']+)'/g;
const EVENT_INSERT_RE = /INSERT INTO events \(([^)]*)\) VALUES \(/g;

function parseSqlTuple(sql, openParen) {
  const values = [];
  let valueStart = openParen + 1;
  let depth = 0;
  let quoted = false;
  for (let index = valueStart; index < sql.length; index += 1) {
    const char = sql[index];
    if (char === "'" && quoted && sql[index + 1] === "'") {
      index += 1;
      continue;
    }
    if (char === "'") {
      quoted = !quoted;
      continue;
    }
    if (quoted) continue;
    if (char === "(") depth += 1;
    else if (char === ")") {
      if (depth === 0) {
        values.push(sql.slice(valueStart, index).trim());
        return values;
      }
      depth -= 1;
    } else if (char === "," && depth === 0) {
      values.push(sql.slice(valueStart, index).trim());
      valueStart = index + 1;
    }
  }
  return null;
}

function parseSqlValue(raw) {
  if (raw === "NULL") return null;
  if (raw === "TRUE") return true;
  if (raw === "FALSE") return false;
  if (/^-?\d+$/.test(raw)) return Number(raw);
  if (raw.startsWith("'") && raw.endsWith("'")) return raw.slice(1, -1).replaceAll("''", "'");
  return raw;
}

/** Load serialized reign rows from all import.sql files for UI assertions. */
export function loadReignsFromImports(importsRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..")) {
  const reigns = [];
  for (const slug of discoverPackages(importsRoot, "import.sql")) {
    const sqlPath = path.join(importsRoot, slug, "import.sql");
    try {
      const sql = readFileSync(sqlPath, "utf8");
      for (const match of sql.matchAll(REIGN_ROW_RE)) {
        const [
          ,
          id,
          dynastyId,
          personId,
          startYear,
          startMonth,
          startDayRaw,
          endYear,
          endMonth,
          endDayRaw,
          startAbs,
          endAbs,
          startConfidence,
          endConfidence,
        ] = match;
        const startDay = startDayRaw === "NULL" ? null : Number(startDayRaw);
        const endDay = endDayRaw === "NULL" ? null : Number(endDayRaw);
        reigns.push({
          id,
          dynastyId,
          personId,
          title: "",
          eraNames: [],
          start: {
            year: Number(startYear),
            month: Number(startMonth),
            ...(startDay != null ? { day: startDay } : {}),
            confidence: startConfidence,
          },
          end: {
            year: Number(endYear),
            month: Number(endMonth),
            ...(endDay != null ? { day: endDay } : {}),
            confidence: endConfidence,
          },
          startAbs: Number(startAbs),
          endAbs: Number(endAbs),
        });
      }
    } catch {
      // package without import.sql
    }
  }
  return reigns;
}

/** Load event rows from all period import.sql files (for event↔fate alignment). */
export function loadEventsFromImports(importsRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..")) {
  /** @type {Map<string, {id:string,confidence:string,atAbs:number,atYear:number,atMonth:number,atDay:number|null}>} */
  const events = new Map();
  for (const slug of discoverPackages(importsRoot, "import.sql")) {
    const sqlPath = path.join(importsRoot, slug, "import.sql");
    try {
      const sql = readFileSync(sqlPath, "utf8");
      for (const match of sql.matchAll(EVENT_INSERT_RE)) {
        const columns = match[1].split(",").map((column) => column.trim());
        const openParen = match.index + match[0].length - 1;
        const rawValues = parseSqlTuple(sql, openParen);
        if (!rawValues) continue;
        const row = Object.fromEntries(columns.map((column, index) => [column, parseSqlValue(rawValues[index])]));
        if (row.id == null || row.at_abs == null || row.at_year == null || row.at_month == null) continue;
        events.set(row.id, {
          id: row.id,
          confidence: row.at_confidence ?? "year",
          atYear: row.at_year,
          atMonth: row.at_month,
          atDay: row.at_day ?? null,
          atAbs: row.at_abs,
        });
      }
    } catch {
      // package without import.sql
    }
  }
  return events;
}

/** Linked fate lines must share at_abs with their event anchor. */
export function validateEventFateAlignment(catalog, events) {
  const failures = [];
  for (const entry of catalog) {
    if (!entry.eventId) continue;
    const event = events.get(entry.eventId);
    if (!event) continue;
    const at = entry.at;
    const level = event.confidence.endsWith("_day") || event.confidence === "day" ? "day" : event.confidence.endsWith("_month") || event.confidence === "month" ? "month" : "year";
    const aligned = level === "day"
      ? at.year === event.atYear && at.month === event.atMonth && at.day === event.atDay
      : level === "month"
        ? at.year === event.atYear && at.month === event.atMonth
        : at.year === event.atYear;
    if (!aligned) {
      failures.push({
        id: entry.id,
        eventId: entry.eventId,
        reason: `event ${entry.eventId} at=${event.atYear}-${event.atMonth}-${event.atDay ?? "?"} != fate at=${at.year}-${at.month}-${at.day ?? "?"}`,
      });
    }
  }
  return failures;
}
