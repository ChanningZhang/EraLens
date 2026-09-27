import { createPrivateKey, createPublicKey, sign, createHash } from "node:crypto";
import { readFile, writeFile, stat } from "node:fs/promises";
import { DatabaseSync } from "node:sqlite";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const args = new Map(process.argv.slice(2).map((arg) => {
  const split = arg.indexOf("=");
  return split < 0 ? [arg, "true"] : [arg.slice(0, split), arg.slice(split + 1)];
}));
const database = path.resolve(root, args.get("--database") ?? "data/mobile/eralens-content.sqlite");
const keyPath = args.get("--private-key");
const datasetVersion = args.get("--dataset-version");
const url = args.get("--url");
const out = path.resolve(root, args.get("--out") ?? "data/mobile/latest.json");
const minAppBuild = Number(args.get("--min-app-build") ?? "1");
if (!keyPath || !datasetVersion || !url || !Number.isSafeInteger(minAppBuild) || minAppBuild < 1) {
  throw new Error("Usage: node scripts/sign-mobile-manifest.mjs --private-key=/secure/path/ed25519.pem --dataset-version=2026.09.27.1 --url=https://host/eralens-content.sqlite [--database=data/mobile/eralens-content.sqlite] [--min-app-build=1] [--out=data/mobile/latest.json]");
}
if (!url.startsWith("https://")) throw new Error("The immutable database URL must use HTTPS.");

const db = new DatabaseSync(database, { readOnly: true });
let metadata;
try {
  metadata = Object.fromEntries(db.prepare("SELECT key, value FROM content_metadata").all().map(({ key, value }) => [key, JSON.parse(value)]));
} finally {
  db.close();
}
if (!metadata.schema_version || !metadata.contract_version || !metadata.source_git_sha) {
  throw new Error("Database snapshot lacks required content_metadata.");
}
const file = await readFile(database);
const info = await stat(database);
const payload = {
  datasetVersion,
  schemaVersion: metadata.schema_version,
  contractVersion: metadata.contract_version,
  minAppBuild,
  sourceGitSha: metadata.source_git_sha,
  url,
  size: info.size,
  sha256: createHash("sha256").update(file).digest("hex"),
};
const canonicalize = (value) => {
  if (Array.isArray(value)) return `[${value.map(canonicalize).join(",")}]`;
  if (value && typeof value === "object") return `{${Object.keys(value).sort().map((key) => `${JSON.stringify(key)}:${canonicalize(value[key])}`).join(",")}}`;
  return JSON.stringify(value);
};
const bytes = Buffer.from(canonicalize(payload));
const privateKey = createPrivateKey(await readFile(path.resolve(keyPath)));
if (privateKey.asymmetricKeyType !== "ed25519") throw new Error("Signing key must be Ed25519.");
const signature = sign(null, bytes, privateKey);
const publicDer = createPublicKey(privateKey).export({ type: "spki", format: "der" });
const publicKeyBase64 = Buffer.from(publicDer).subarray(-32).toString("base64");
const envelope = { payload: bytes.toString("base64"), signature: signature.toString("base64") };
await writeFile(out, `${JSON.stringify(envelope, null, 2)}\n`, { mode: 0o644 });
console.log(JSON.stringify({ output: path.relative(root, out), datasetVersion, size: info.size, sha256: payload.sha256, publicKeyBase64 }, null, 2));
