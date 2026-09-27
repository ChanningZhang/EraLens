import { readFileSync, readdirSync, statSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const importsRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

function add(owners, table, key, slug, index, description = key, row = null) {
  if (!key || key.includes("undefined")) {
    throw new Error(`${slug}: ${table}[${index}] has no stable row key`);
  }
  const ownerKey = `${table}\0${key}`;
  const rows = owners.get(ownerKey) ?? [];
  rows.push({ slug, index, description, row });
  owners.set(ownerKey, rows);
}

function collectPackageRows(owners, slug, cache) {
  const byId = [
    ["persons", cache.persons],
    ["dynasty_groups", cache.dynastyGroups],
    ["dynasties", cache.dynasties],
    ["dynasty_lane_groups", cache.dynastyLaneGroups],
    ["reigns", cache.reigns],
    ["events", cache.events],
    ["event_locations", cache.eventLocations],
    ["dynasty_capitals", cache.capitals],
  ];
  for (const [table, rows] of byId) {
    (rows ?? []).forEach((row, index) => add(owners, table, row.id, slug, index, row.id, row));
  }

  (cache.relations ?? []).forEach((row, index) => {
    add(owners, "relations.id", row.id, slug, index, row.id, row);
    add(owners, "relations.unique", [row.fromRef, row.toRef, row.kind].join("|"), slug, index, row.id, row);
  });
  (cache.reignCapitals ?? []).forEach((row, index) => {
    add(owners, "reign_capitals", [row.reignId, row.capitalId].join("|"), slug, index, undefined, row);
  });
  (cache.events ?? []).forEach((event, index) => {
    for (const dynastyId of event.dynastyIds ?? []) {
      add(owners, "event_dynasties", [event.id, dynastyId].join("|"), slug, index);
    }
    for (const personId of event.participantIds ?? []) {
      add(owners, "event_participants", [event.id, personId].join("|"), slug, index);
    }
  });
  (cache.supplementalEventDynasties ?? []).forEach((row, index) => {
    add(owners, "event_dynasties", [row.eventId, row.dynastyId].join("|"), slug, index);
  });
  (cache.supplementalEventParticipants ?? []).forEach((row, index) => {
    add(owners, "event_participants", [row.eventId, row.personId].join("|"), slug, index);
  });
  (cache.updates ?? []).forEach((row, index) => {
    add(owners, "updates", [row.table, row.id, row.column].join("|"), slug, index);
    // An update is another writer for the target row. Keep it in the same
    // ownership namespace so a patch package cannot shadow the row owner.
    add(owners, row.table, row.id, slug, index);
  });
}

function auditPackageSql(owners, slug, cache) {
  const literalsFor = (where, column) => {
    const escaped = column.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    const match = new RegExp(`\\b${escaped}\\s*(?:=\\s*'((?:[^']|'')*)'|IN\\s*\\(([^)]*)\\))`, "i").exec(where);
    if (!match) return null;
    return match[1] != null
      ? [match[1].replaceAll("''", "'")]
      : [...match[2].matchAll(/'((?:[^']|'')*)'/g)].map((value) => value[1].replaceAll("''", "'"));
  };
  const rejectExternal = (table, key, operation, field) => {
    const otherOwners = owners.get(`${table}\0${key}`) ?? [];
    if (otherOwners.some((owner) => owner.slug !== slug)) {
      throw new Error(`${slug}.${field} ${operation}s ${table}.${key}, owned by ${otherOwners.filter((owner) => owner.slug !== slug).map((owner) => owner.slug).join(", ")}`);
    }
  };
  for (const [field, sql] of [["preSql", cache.preSql], ["postSql", cache.postSql]]) {
    if (!sql) continue;
    for (const match of sql.matchAll(/\bDELETE\s+FROM\s+([\w"]+)\b([\s\S]*?);/gi)) {
      if (!/\bWHERE\b/i.test(match[2])) {
        throw new Error(`${slug}.${field} contains an unscoped DELETE FROM ${match[1]}; package cleanup must target specific rows`);
      }
      const table = match[1].replaceAll('"', "").toLowerCase();
      const where = match[2].slice(match[2].search(/\bWHERE\b/i) + 5);
      const ids = literalsFor(where, "id");
      const primaryTables = {
        persons: "persons", dynasty_groups: "dynasty_groups", dynasties: "dynasties",
        dynasty_lane_groups: "dynasty_lane_groups", reigns: "reigns", events: "events",
        event_locations: "event_locations", dynasty_capitals: "dynasty_capitals", relations: "relations.id",
      };
      if (ids) for (const id of ids) rejectExternal(primaryTables[table] ?? `${table}.id`, id, "DELETE", field);

      const keySpecs = {
        event_dynasties: ["event_dynasties", ["event_id", "dynasty_id"]],
        event_participants: ["event_participants", ["event_id", "person_id"]],
        reign_capitals: ["reign_capitals", ["reign_id", "capital_id"]],
      };
      const spec = keySpecs[table];
      if (spec) {
        const [ownerTable, columns] = spec;
        const filters = columns.map((column) => literalsFor(where, column));
        if (!filters.some((values) => values != null)) continue;
        for (const [ownerKey, rows] of owners) {
          const [candidateTable, key] = ownerKey.split("\0");
          if (candidateTable !== ownerTable || rows.every((row) => row.slug === slug)) continue;
          const parts = key.split("|");
          if (filters.every((values, index) => values == null || values.includes(parts[index]))) {
            throw new Error(`${slug}.${field} DELETEs ${ownerTable} ${key}, owned by ${rows.filter((row) => row.slug !== slug).map((row) => row.slug).join(", ")}`);
          }
        }
      }

      const foreignColumns = {
        reigns: ["dynasty_id", "person_id"],
        dynasty_capitals: ["dynasty_id"],
        relations: ["from_type", "from_id", "to_type", "to_id", "event_id"],
      }[table] ?? [];
      if (foreignColumns.length) {
        const filters = new Map(foreignColumns.map((column) => [column, literalsFor(where, column)]));
        if (![...filters.values()].some((values) => values != null)) continue;
        const excludedIdsMatch = /\bid\s+NOT\s+IN\s*\(([^)]*)\)/i.exec(where);
        const excludedIds = excludedIdsMatch
          ? [...excludedIdsMatch[1].matchAll(/'((?:[^']|'')*)'/g)].map((value) => value[1].replaceAll("''", "'"))
          : [];
        for (const [ownerKey, rows] of owners) {
          const [candidateTable] = ownerKey.split("\0");
          const expectedTable = table === "relations" ? "relations.id" : table;
          if (candidateTable !== expectedTable) continue;
          for (const owner of rows) {
            if (owner.slug === slug || !owner.row) continue;
            const row = owner.row;
            if (excludedIds.includes(row.id)) continue;
            const values = {
              dynasty_id: row.dynastyId,
              person_id: row.personId,
              event_id: row.eventId,
              from_type: row.fromRef?.split(":", 1)[0],
              from_id: row.fromRef?.split(":").slice(1).join(":"),
              to_type: row.toRef?.split(":", 1)[0],
              to_id: row.toRef?.split(":").slice(1).join(":"),
            };
            const matches = [...filters].every(([column, allowed]) => allowed == null || allowed.includes(values[column]));
            if (matches) {
              throw new Error(`${slug}.${field} DELETEs ${table} row ${owner.description}, owned by ${owner.slug}`);
            }
          }
        }
      }
    }
    for (const match of sql.matchAll(/\bUPDATE\s+([\w"]+)\s+SET\b[\s\S]*?\bWHERE\b([\s\S]*?);/gi)) {
      const table = match[1].replaceAll('"', "").toLowerCase();
      const where = match[2];
      const ids = literalsFor(where, "id");
      if (!ids) throw new Error(`${slug}.${field} contains an UPDATE without a direct id target; move field data into the owning cache row`);
      for (const id of ids) rejectExternal(table, id, "UPDATE", field);
    }
  }
}

export function auditPackageOwnership(root = importsRoot) {
  const owners = new Map();
  const packageCaches = [];
  const slugs = readdirSync(root).filter((slug) => {
    const directory = path.join(root, slug);
    return statSync(directory).isDirectory() && statSync(path.join(directory, "cache.json"), { throwIfNoEntry: false });
  }).sort();

  for (const slug of slugs) {
    const cache = JSON.parse(readFileSync(path.join(root, slug, "cache.json"), "utf8"));
    collectPackageRows(owners, slug, cache);
    packageCaches.push({ slug, cache });
  }

  const eventOwners = new Map();
  const locationIds = new Set();
  for (const { slug, cache } of packageCaches) {
    for (const event of cache.events ?? []) {
      eventOwners.set(event.id, [...(eventOwners.get(event.id) ?? []), { slug, event }]);
    }
    for (const location of cache.eventLocations ?? []) locationIds.add(location.id);
  }
  for (const { slug, cache } of packageCaches) {
    for (const location of cache.eventLocations ?? []) {
      const matches = eventOwners.get(location.eventId) ?? [];
      if (matches.length !== 1 || matches[0].event.locationId !== location.id) {
        throw new Error(`${slug}: event location ${location.id} must be referenced by its unique owning event ${location.eventId}`);
      }
    }
    for (const event of cache.events ?? []) {
      if (event.locationId && !locationIds.has(event.locationId)) {
        throw new Error(`${slug}: event ${event.id} references missing event location ${event.locationId}`);
      }
    }
  }

  for (const { slug, cache } of packageCaches) auditPackageSql(owners, slug, cache);

  const conflicts = [...owners.entries()].filter(([, rows]) => rows.length > 1);
  if (conflicts.length) {
    const details = conflicts.map(([key, rows]) => {
      const [table, rowKey] = key.split("\0");
      return `- ${table} ${rowKey}: ${rows.map((row) => `${row.slug}[${row.index}]`).join(", ")}`;
    });
    throw new Error(`Import package row ownership conflicts (${conflicts.length}):\n${details.join("\n")}`);
  }
  return { packageCount: slugs.length, rowCount: owners.size };
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const result = auditPackageOwnership(process.argv[2] ? path.resolve(process.argv[2]) : importsRoot);
  console.log(`Import package ownership OK: ${result.packageCount} packages, ${result.rowCount} rows.`);
}
