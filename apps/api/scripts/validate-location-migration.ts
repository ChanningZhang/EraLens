/** Compare an archived pre-upgrade tenure snapshot with the upgraded SQLite export. */
import { readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { DatabaseSync } from "node:sqlite";
import { capitalLocations, capitalSegmentsForReign, mapLocationMapping } from "@eralens/shared";
import { mapReign } from "@eralens/data-access/sqlite";

const option = (name: string) => process.argv.find(arg => arg.startsWith(`--${name}=`))?.slice(name.length + 3);
const baseline = option("baseline");
const file = option("db");
if (!baseline || !file) throw new Error("Usage: tsx scripts/validate-location-migration.ts --baseline=<tenures.json> --db=<upgraded.sqlite>");
type Tenure = { reignId: string; capitalId: string; interval: unknown };
const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),"../../..");
const db = new DatabaseSync(path.resolve(root,file), { readOnly: true });
try {
  const reigns = db.prepare("SELECT * FROM reigns").all().map(row => mapReign(row as never));
  const locationMappings = db.prepare(`SELECT m.*, json_object('id',l.id,'modern_name',l.modern_name,
    'longitude',l.longitude,'latitude',l.latitude,'coordinate_system',l.coordinate_system) AS location
    FROM location_mapping m JOIN locations l ON l.id=m.location_id`).all().map(mapLocationMapping);
  const capitals = capitalLocations({ reigns, locationMappings });
  const after: Tenure[] = reigns.flatMap(reign => capitalSegmentsForReign(reign, reigns, capitals).map(segment => ({
    reignId: reign.id, capitalId: segment.capital.id.split(":").at(-1)!, interval: segment.overlapInterval,
  })));
  const before = JSON.parse(readFileSync(path.resolve(root,baseline), "utf8")) as Tenure[];
  const canonical = (rows: Tenure[]) => new Map(rows.map(row => [`${row.reignId}|${row.capitalId}`, JSON.stringify(row.interval)]));
  const oldRows = canonical(before), newRows = canonical(after);
  const differences = [...new Set([...oldRows.keys(), ...newRows.keys()])].filter(key => oldRows.get(key) !== newRows.get(key));
  console.log(JSON.stringify({ before: before.length, after: after.length, differences }, null, 2));
  if (differences.length || before.length !== after.length) process.exitCode = 1;
} finally { db.close(); }
