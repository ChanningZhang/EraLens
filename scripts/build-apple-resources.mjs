import { access, cp, mkdir, rm } from "node:fs/promises";
import { execFileSync } from "node:child_process";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const args = new Map(process.argv.slice(2).map((item) => {
  const [key, ...rest] = item.replace(/^--/, "").split("=");
  return [key, rest.join("=")];
}));
const platform = args.get("platform");
if (!(["ios", "mac"].includes(platform))) throw new Error("Usage: pnpm apple:resources --platform=ios|mac [--output=<directory>]");

const database = path.join(root, "data/mobile/eralens-content.sqlite");
const versions = path.join(root, "data/mobile/versions.json");
for (const [file, message] of [[database, "缺少内容库，请先执行 pnpm db:setup"], [versions, "缺少内容版本配置"]]) {
  try { await access(file); } catch { throw new Error(`${message}：${path.relative(root, file)}`); }
}

function run(command, commandArgs) {
  execFileSync(command, commandArgs, { cwd: root, stdio: "inherit" });
}

run("pnpm", ["data:validate"]);
run("pnpm", ["--filter", "@eralens/web", `build:${platform}`]);

const webOutput = path.join(root, `apps/web/dist-${platform}`);
const output = path.resolve(root, args.get("output") ?? `.build/apple/${platform}/NativeResources`);
await rm(output, { recursive: true, force: true });
await mkdir(path.join(output, "Content"), { recursive: true });
await cp(webOutput, path.join(output, "Web"), { recursive: true });
await cp(database, path.join(output, "Content/eralens-content.sqlite"));
await cp(versions, path.join(output, "Content/versions.json"));
console.log(`Native resources ready: ${output}`);
