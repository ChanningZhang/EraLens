import { createHash } from "node:crypto";
import { execFileSync } from "node:child_process";
import { readFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const base = process.argv.find((arg) => arg.startsWith("--base="))?.slice(7);
if (!base) throw new Error("Usage: pnpm release:classify -- --base=<last-data-or-app-tag>");
const git = (...args) => execFileSync("git", args, { cwd: root, encoding: "utf8" }).trimEnd();
const gitBuffer = (...args) => execFileSync("git", args, { cwd: root, stdio: ["ignore", "pipe", "ignore"] });
git("rev-parse", "--verify", `${base}^{commit}`);
const changed = new Set(git("diff", "--name-only", base, "--").split("\n").filter(Boolean));
for (const file of git("ls-files", "--others", "--exclude-standard").split("\n").filter(Boolean)) changed.add(file);
const files = [...changed].sort();

const contractPaths = [
  "packages/shared/src/schema.ts", "packages/data-access/src/sqliteRepository.ts",
  "data/mobile/schema.sql", "data/mobile/versions.json",
];
const hash = createHash("sha256");
for (const file of contractPaths) {
  let content = "";
  try { content = await readFile(path.join(root, file)); } catch { /* candidate may delete the file */ }
  hash.update(`${file}\0`); hash.update(content); hash.update("\0");
}
const candidateFingerprint = hash.copy().digest("hex");
const baseHash = createHash("sha256");
for (const file of contractPaths) {
  let content = "";
  try { content = gitBuffer("show", `${base}:${file}`); } catch { /* file did not exist in base */ }
  baseHash.update(`${file}\0`); baseHash.update(content); baseHash.update("\0");
}
const baseFingerprint = baseHash.digest("hex");

let classification = "DATA_ONLY";
const reasons = [];
const manifestChanges = new Set();
for (const file of files) {
  if (/^(apps|packages|scripts)\//.test(file) || /(^|\/)(package\.json|pnpm-lock\.yaml|capacitor\.config\.[cm]?ts|.*\.xcodeproj\/|.*\.xcworkspace\/)/.test(file) || file === "package.json" || file === "pnpm-lock.yaml") {
    classification = "APP_RELEASE_REQUIRED";
    reasons.push(`${file}: runtime or build infrastructure changed`);
    continue;
  }
  if (/^data\/imports\//.test(file)) {
    const rel = file.slice("data/imports/".length);
    if (rel.startsWith("lib/")) {
      classification = "APP_RELEASE_REQUIRED";
      reasons.push(`${file}: shared data generation or validation infrastructure changed`);
      continue;
    }
    if (/(^|\/)generate\.mjs$/.test(rel) || /\.(sql|sh)$/.test(rel)) {
      if (classification !== "APP_RELEASE_REQUIRED") classification = "MANUAL_REVIEW";
      reasons.push(`${file}: generated data or generation logic needs review`);
      continue;
    }
    if (rel.endsWith("manifest.json")) {
      manifestChanges.add(file);
      continue;
    }
    if (/\.(json|csv|tsv|yaml|yml)$/.test(rel)) continue;
    if (classification !== "APP_RELEASE_REQUIRED") classification = "MANUAL_REVIEW";
    reasons.push(`${file}: import package change is not a recognized data-only file`);
    continue;
  }
  if (file === "IOS_MIGRATION_PLAN.md" || file.startsWith("docs/") || file.startsWith(".cursor/skills/")) {
    if (classification !== "APP_RELEASE_REQUIRED") classification = "MANUAL_REVIEW";
    reasons.push(`${file}: documentation or workflow changed`);
    continue;
  }
  classification = "APP_RELEASE_REQUIRED";
  reasons.push(`${file}: unclassified application path`);
}

for (const file of manifestChanges) {
  let current;
  let original;
  try {
    current = JSON.parse(await readFile(path.join(root, file), "utf8"));
    original = JSON.parse(git("show", `${base}:${file}`));
  } catch {
    if (classification !== "APP_RELEASE_REQUIRED") classification = "MANUAL_REVIEW";
    reasons.push(`${file}: manifest is new, removed, or invalid`);
    continue;
  }
  const safeKeys = new Set(["notes", "sources"]);
  const keys = new Set([...Object.keys(current), ...Object.keys(original)]);
  const unsafe = [...keys].filter((key) => !safeKeys.has(key) && JSON.stringify(current[key]) !== JSON.stringify(original[key]));
  if (unsafe.length) {
    if (classification !== "APP_RELEASE_REQUIRED") classification = "MANUAL_REVIEW";
    reasons.push(`${file}: manifest fields outside notes/sources changed (${unsafe.join(", ")})`);
  }
}
if (candidateFingerprint !== baseFingerprint) {
  classification = "APP_RELEASE_REQUIRED";
  reasons.push("runtime/schema contract fingerprint changed");
}
if (!files.length) reasons.push("no changes detected against the selected base");
console.log(JSON.stringify({ classification, base, changedPaths: files, contractFingerprint: { base: baseFingerprint, candidate: candidateFingerprint }, reasons }, null, 2));
