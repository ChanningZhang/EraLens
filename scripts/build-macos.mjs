import { access, cp, mkdir, readFile, rm, symlink, writeFile } from "node:fs/promises";
import { execFileSync } from "node:child_process";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const outputRoot = path.join(root, ".build/macos");
const appPath = path.join(outputRoot, "EraLens.app");
const resourcesPath = path.join(appPath, "Contents/Resources");
const nativeResourcesPath = path.join(outputRoot, "native-resources/NativeResources");
const iconPath = path.join(root, "apps/ios/ios/App/App/Assets.xcassets/AppIcon.appiconset/AppIcon-512@2x.png");
const dmgPath = path.join(outputRoot, "EraLens-0.1.0-arm64.dmg");

function run(command, args, options = {}) {
  execFileSync(command, args, { cwd: root, stdio: "inherit", ...options });
}

async function ensureFile(file, message) {
  try { await access(file); } catch { throw new Error(`${message}: ${path.relative(root, file)}`); }
}

async function makeIcon() {
  const iconset = path.join(outputRoot, "EraLens.iconset");
  await rm(iconset, { recursive: true, force: true });
  await mkdir(iconset, { recursive: true });
  for (const size of [16, 32, 128, 256, 512]) {
    for (const multiplier of [1, 2]) {
      const outputSize = size * multiplier;
      run("sips", ["-z", String(outputSize), String(outputSize), iconPath, "--out", path.join(iconset, `icon_${size}x${size}${multiplier === 2 ? "@2x" : ""}.png`)], { stdio: "ignore" });
    }
  }
  const iconChunks = [
    ["icp4", "icon_16x16.png"],
    ["icp5", "icon_16x16@2x.png"],
    ["icp6", "icon_32x32@2x.png"],
    ["ic07", "icon_128x128.png"],
    ["ic08", "icon_256x256.png"],
    ["ic09", "icon_512x512.png"],
    ["ic10", "icon_512x512@2x.png"],
  ];
  const chunks = await Promise.all(iconChunks.map(async ([type, filename]) => {
    const image = await readFile(path.join(iconset, filename));
    const chunk = Buffer.alloc(8 + image.length);
    chunk.write(type, 0, 4, "ascii");
    chunk.writeUInt32BE(chunk.length, 4);
    image.copy(chunk, 8);
    return chunk;
  }));
  const body = Buffer.concat(chunks);
  const icns = Buffer.alloc(8 + body.length);
  icns.write("icns", 0, 4, "ascii");
  icns.writeUInt32BE(icns.length, 4);
  body.copy(icns, 8);
  await writeFile(path.join(outputRoot, "EraLens.icns"), icns);
}

async function main() {
  if (process.platform !== "darwin" || process.arch !== "arm64") throw new Error("Mac 打包目前需要 Apple Silicon Mac。 ");
  if (process.argv.includes("--test")) {
    run("swift", ["test", "--package-path", "packages/apple-native", "--scratch-path", ".build/apple-native", "--triple", "arm64-apple-macosx13.1"]);
    return;
  }
  await ensureFile(iconPath, "缺少应用图标");
  run("pnpm", ["run", "apple:resources", "--", "--platform=mac", `--output=${nativeResourcesPath}`]);
  await rm(appPath, { recursive: true, force: true });
  await mkdir(resourcesPath, { recursive: true });

  const swiftArgs = ["--package-path", "apps/macos", "--scratch-path", ".build/macos/swift", "--triple", "arm64-apple-macosx13.1"];
  run("swift", ["build", ...swiftArgs, "--configuration", "release"]);
  const binaryRoot = execFileSync("swift", ["build", ...swiftArgs, "--configuration", "release", "--show-bin-path"], { cwd: root, encoding: "utf8" }).trim();
  const contents = path.join(appPath, "Contents");
  const macosPath = path.join(contents, "MacOS");
  const iconsPath = path.join(contents, "Resources");
  await mkdir(macosPath, { recursive: true });
  await mkdir(iconsPath, { recursive: true });
  await cp(path.join(binaryRoot, "EraLens"), path.join(macosPath, "EraLens"));
  await cp(nativeResourcesPath, path.join(resourcesPath, "NativeResources"), { recursive: true });
  await makeIcon();
  await cp(path.join(outputRoot, "EraLens.icns"), path.join(iconsPath, "EraLens.icns"));

  const plist = `<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleExecutable</key><string>EraLens</string>
<key>CFBundleIdentifier</key><string>com.eralens.mac</string>
<key>CFBundleName</key><string>EraLens</string>
<key>CFBundleDisplayName</key><string>EraLens</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>0.1.0</string>
<key>CFBundleVersion</key><string>1</string>
<key>CFBundleIconFile</key><string>EraLens</string>
<key>LSMinimumSystemVersion</key><string>13.1</string>
<key>NSHighResolutionCapable</key><true/>
<key>NSPrincipalClass</key><string>NSApplication</string>
<key>LSApplicationCategoryType</key><string>public.app-category.education</string>
</dict></plist>`;
  await writeFile(path.join(contents, "Info.plist"), plist);
  run("codesign", ["--force", "--deep", "--sign", "-", appPath]);

  if (process.argv.includes("--dmg")) {
    const staging = path.join(outputRoot, "dmg-staging");
    await rm(staging, { recursive: true, force: true });
    await mkdir(staging, { recursive: true });
    await cp(appPath, path.join(staging, "EraLens.app"), { recursive: true });
    await symlink("/Applications", path.join(staging, "Applications"));
    await rm(dmgPath, { force: true });
    run("hdiutil", ["create", "-volname", "EraLens", "-srcfolder", staging, "-format", "UDZO", dmgPath]);
    run("hdiutil", ["verify", dmgPath]);
    console.log(`DMG ready: ${dmgPath}`);
  } else {
    console.log(`App ready: ${appPath}`);
    if (process.argv.includes("--open")) run("open", [appPath]);
  }
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : error);
  process.exitCode = 1;
});
