import { readFileSync, readdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

function packageSlugs(root, relative = "") {
  const directory = path.join(root, relative);
  const entries = readdirSync(directory, { withFileTypes: true });
  const slugs = [];
  for (const entry of entries) {
    if (!entry.isDirectory()) continue;
    const child = path.join(relative, entry.name);
    if (readdirSync(path.join(root, child)).includes("cache.json")) slugs.push(child);
    else slugs.push(...packageSlugs(root, child));
  }
  return slugs;
}

function packageCaches(importsRoot) {
  return packageSlugs(importsRoot).map(slug => JSON.parse(readFileSync(path.join(importsRoot, slug, "cache.json"), "utf8")));
}

/** Load normalized reign records directly from authoritative import caches. */
export function loadReignsFromImports(importsRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..")) {
  return packageCaches(importsRoot).flatMap(cache => (cache.reigns ?? []).map(reign => ({
    ...reign,
    title: reign.title ?? "",
    eraNames: reign.eraNames ?? [],
    start: { ...reign.start, confidence: reign.start.confidence ?? reign.startConfidence ?? "year" },
    end: reign.end ? { ...reign.end, confidence: reign.end.confidence ?? reign.endConfidence ?? "year" } : null,
    startAbs: reign.startAbs ?? reign.start.abs,
    endAbs: reign.endAbs ?? reign.end?.abs ?? null,
  })));
}

/** Load event anchors directly from authoritative import caches. */
export function loadEventsFromImports(importsRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..")) {
  const events = new Map();
  for (const cache of packageCaches(importsRoot)) for (const event of cache.events ?? []) {
    if (event.atAbs == null && event.at?.abs == null) continue;
    events.set(event.id, {
      id: event.id,
      confidence: event.atConfidence ?? event.at?.confidence ?? "year",
      atYear: event.at?.year,
      atMonth: event.at?.month,
      atDay: event.at?.day ?? null,
      atAbs: event.atAbs ?? event.at?.abs,
    });
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
