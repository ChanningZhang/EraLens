import { assertEntityAssociation } from "../../../packages/shared/src/entityAssociations.mjs";
import { readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { discoverPackages } from "./discoverPackages.mjs";

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
    ["reigns", cache.reigns],
    ["events", cache.events],
    ["locations", cache.locations],
    ["location_mapping", cache.locationMappings],
  ];
  for (const [table, rows] of byId) {
    (rows ?? []).forEach((row, index) => add(owners, table, row.id, slug, index, row.id, row));
  }

  (cache.relations ?? []).forEach((row, index) => {
    add(owners, "relations.id", row.id, slug, index, row.id, row);
    add(owners, "relations.unique", [row.fromRef, row.toRef, row.kind].join("|"), slug, index, row.id, row);
  });

  for (const field of ["supplementalEventDynasties", "supplementalEventParticipants"]) if (Object.hasOwn(cache, field)) throw new Error(`${slug}: legacy association array ${field}`);
  for (const event of cache.events ?? []) for (const field of ["participantIds", "dynastyIds"]) if (Object.hasOwn(event, field)) throw new Error(`${slug}: legacy event association field ${field}`);
  if (Object.hasOwn(cache, "associations") && slug !== "entity-associations") throw new Error(`${slug}: ordinary associations belong to entity-associations`);
  (cache.associations ?? []).forEach((row,index) => {
    assertEntityAssociation(row);
    add(owners, "entity_associations", JSON.stringify([row.aRef,row.bRef]), slug, index, `${row.aRef} <-> ${row.bRef}`, row);
  });
  for (const row of cache.relations ?? []) {
    if (!["succession","killed","surrender","abdication","captured","conquered"].includes(row.kind)) throw new Error(`${slug}: invalid relation kind ${row.kind}`);
    if (row.kind === "succession" ? !/^person:.+$/u.test(row.fromRef) || !/^person:.+$/u.test(row.toRef) : !/^(person|reign):.+$/u.test(row.fromRef) || !/^person:.+$/u.test(row.toRef) || row.atAbs == null) throw new Error(`${slug}: invalid relation endpoints/date ${row.id}`);
  }
  if (slug === "entity-associations" && cache.manifest?.counts?.associations !== (cache.associations ?? []).length) throw new Error(`${slug}: manifest.counts.associations does not match records`);
  for (const key of Object.keys(cache.manifest?.counts ?? {})) {
    if (/^(existing|supplemental)Event(Dynasty|Participant)Links$/.test(key)) {
      throw new Error(`${slug}: legacy association count ${key}`);
    }
  }
  const countFields={persons:"persons",dynasties:"dynasties",reigns:"reigns",events:"events",relations:"relations",associations:"associations",locations:"locations",locationMappings:"locationMappings",dynastyGroups:"dynastyGroups"};
  for (const [key,value] of Object.entries(cache.manifest?.counts ?? {})) if (countFields[key] && value !== (cache[countFields[key]] ?? []).length) throw new Error(`${slug}: manifest.counts.${key} does not match records`);
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
    if (/\b(?:event_dynasties|event_participants)\b/i.test(sql)) throw new Error(`${slug}.${field}: legacy association table`);
    if (slug !== "entity-associations" && /\b(?:INSERT\s+INTO|DELETE\s+FROM|UPDATE)\s+entity_associations\b/i.test(sql)) throw new Error(`${slug}.${field}: only entity-associations may maintain ordinary associations`);
    for (const match of sql.matchAll(/\bDELETE\s+FROM\s+([\w"]+)\b([\s\S]*?);/gi)) {
      if (!/\bWHERE\b/i.test(match[2])) {
        throw new Error(`${slug}.${field} contains an unscoped DELETE FROM ${match[1]}; package cleanup must target specific rows`);
      }
      const table = match[1].replaceAll('"', "").toLowerCase();
      const where = match[2].slice(match[2].search(/\bWHERE\b/i) + 5);
      const ids = literalsFor(where, "id");
      const primaryTables = {
        persons: "persons", dynasty_groups: "dynasty_groups", dynasties: "dynasties",
        reigns: "reigns", events: "events",
        locations: "locations", location_mapping: "location_mapping", relations: "relations.id",
      };
      if (ids) for (const id of ids) rejectExternal(primaryTables[table] ?? `${table}.id`, id, "DELETE", field);

      if (table === "entity_associations") {
        if (slug !== "entity-associations") throw new Error(`${slug}.${field} cannot delete associations owned by the centralized package`);
        const columns = ["a_type", "a_id", "b_type", "b_id"];
        const termPattern = /\b(a_type|a_id|b_type|b_id)\s*=\s*'((?:[^']|'')*)'/gi;
        const terms = [...where.matchAll(termPattern)];
        const values = new Map(terms.map(term => [term[1].toLowerCase(), term[2].replaceAll("''", "'")]));
        if (terms.length !== 4 || !columns.every(column => values.has(column)) ||
            !/^\s*KEY(?:\s+AND\s+KEY){3}\s*$/i.test(where.replace(termPattern, "KEY"))) {
          throw new Error(`${slug}.${field}: association cleanup must identify a complete pair key`);
        }
        assertEntityAssociation({
          aRef: `${values.get("a_type")}:${values.get("a_id")}`,
          bRef: `${values.get("b_type")}:${values.get("b_id")}`,
        });
      }
      const foreignColumns = {
        reigns: ["dynasty_id", "person_id"],
        location_mapping: ["kind", "external_id", "location_id"],
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
              kind: row.kind, external_id: row.externalId, location_id: row.locationId,
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
  const slugs = discoverPackages(root);

  for (const slug of slugs) {
    const cache = JSON.parse(readFileSync(path.join(root, slug, "cache.json"), "utf8"));
    collectPackageRows(owners, slug, cache);
    packageCaches.push({ slug, cache });
  }

  const locationIds = new Set(packageCaches.flatMap(({cache}) => (cache.locations ?? []).map(row => row.id)));
  const uniqueLocations = new Set();
  for (const {slug, cache} of packageCaches) {
    for (const field of ["capitals", "reignCapitals", "eventLocations"]) {
      if (cache[field]?.length) throw new Error(`${slug}: legacy geography array ${field}`);
    }
    for (const event of cache.events ?? []) if (event.locationId != null) throw new Error(`${slug}: legacy event locationId`);
    for (const row of cache.locations ?? []) {
      if (slug !== "locations") throw new Error(`${slug}: spatial records belong to the locations package`);
      if (!row.modernName?.trim() || !Number.isFinite(row.longitude) || !Number.isFinite(row.latitude) || Math.abs(row.longitude)>180 || Math.abs(row.latitude)>90 || !["GCJ02","WGS84"].includes(row.coordinateSystem)) throw new Error(`${slug}: invalid location ${row.id}`);
      const key=JSON.stringify([row.modernName,row.longitude.toFixed(7),row.latitude.toFixed(7),row.coordinateSystem]);
      if (uniqueLocations.has(key)) throw new Error(`${slug}: duplicate spatial record ${row.id}`);
      uniqueLocations.add(key);
    }
    for (const row of cache.locationMappings ?? []) {
      const table={dynasty:"dynasties",reign:"reigns",event:"events"}[row.kind];
      if (!table || !owners.has(`${table}\0${row.externalId}`) || !locationIds.has(row.locationId)) throw new Error(`${slug}: orphan mapping ${row.id}`);
      if (row.claimTrack != null || !row.historicalName?.trim() || /[()（）]/.test(row.historicalName) || row.historicalName.split("/").some(name=>!name.trim()) || new Set(row.historicalName.split("/")).size !== row.historicalName.split("/").length) throw new Error(`${slug}: invalid historical name or claimTrack in ${row.id}`);
      if (row.kind === "event" ? row.start != null || row.end != null || row.role != null : !row.start || !row.end || !["primary","secondary","temporary"].includes(row.role)) throw new Error(`${slug}: invalid mapping interval ${row.id}`);
    }
  }

  const entities=new Map([ ["dynasty",new Set(packageCaches.flatMap(p=>p.cache.dynasties ?? []).map(r=>r.id))], ["person",new Set(packageCaches.flatMap(p=>p.cache.persons ?? []).map(r=>r.id))], ["event",new Set(packageCaches.flatMap(p=>p.cache.events ?? []).map(r=>r.id))] ]);
  for (const {slug,cache} of packageCaches) for (const row of cache.associations ?? []) for (const ref of [row.aRef,row.bRef]) {
    const colon=ref.indexOf(":"), type=ref.slice(0,colon), id=ref.slice(colon+1);
    if (!entities.get(type)?.has(id)) throw new Error(`${slug}: dangling association endpoint ${ref}`);
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
