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
