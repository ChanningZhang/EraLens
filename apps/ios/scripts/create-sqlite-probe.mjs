import { mkdir, rm } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { DatabaseSync } from "node:sqlite";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../web/public/assets/databases");
const file = path.join(root, "eralens-probe.db");

await mkdir(root, { recursive: true });
await rm(file, { force: true });
const database = new DatabaseSync(file);
database.exec(`
  CREATE TABLE ios_probe (
    id TEXT PRIMARY KEY NOT NULL,
    label TEXT NOT NULL,
    historical_year INTEGER NOT NULL
  );
  CREATE TABLE ios_probe_result (
    id INTEGER PRIMARY KEY CHECK (id = 1),
    label TEXT NOT NULL,
    historical_year INTEGER NOT NULL,
    color_mix_supported INTEGER NOT NULL,
    color_mix_computed TEXT NOT NULL
  );
`);
database.prepare("INSERT INTO ios_probe (id, label, historical_year) VALUES (?, ?, ?)")
  .run("qin-unification", "秦始皇统一六国", -221);
database.close();
