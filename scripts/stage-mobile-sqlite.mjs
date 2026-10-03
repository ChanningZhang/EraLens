import { copyFile, mkdir } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const source = path.join(root, "data/mobile/eralens-content.sqlite");
const targetDir = path.join(root, "apps/web/public/assets/databases");
const target = path.join(targetDir, "eralens-content.db");
await mkdir(targetDir, { recursive: true });
await copyFile(source, target);
await copyFile(path.join(root, "data/mobile/versions.json"), path.join(targetDir, "eralens-content.versions.json"));
console.log(`Staged SQLite content database at ${path.relative(root, target)}`);
