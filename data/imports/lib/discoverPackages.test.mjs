import { test } from "node:test";
import assert from "node:assert/strict";
import { mkdtempSync, mkdirSync, writeFileSync, symlinkSync, rmSync } from "node:fs";
import { tmpdir } from "node:os";
import path from "node:path";
import { discoverPackages, resolvePackageDirectory } from "./discoverPackages.mjs";
import { auditPackageOwnership } from "./auditPackageOwnership.mjs";

test("discovery includes nested packages and skips grouping folders and symlinks", () => {
  const root = mkdtempSync(path.join(tmpdir(), "eralens-packages-"));
  try {
    for (const slug of ["flat", "period/qi", "period/other/deep", ".hidden/ignored"]) {
      const dir = path.join(root, slug);
      mkdirSync(dir, { recursive: true });
      writeFileSync(path.join(dir, "cache.json"), "{}");
      writeFileSync(path.join(dir, "import.sql"), "BEGIN; COMMIT;");
    }
    symlinkSync(root, path.join(root, "loop"));
    assert.deepEqual(discoverPackages(root), ["flat", "period/other/deep", "period/qi"]);
    assert.deepEqual(discoverPackages(root, "import.sql"), discoverPackages(root));
    assert.equal(resolvePackageDirectory(root, "period/qi"), path.join(root, "period/qi"));
    for (const slug of ["../outside", "/outside", "period/../flat", "period//qi", "period\\qi", ".hidden"]) {
      assert.throws(() => resolvePackageDirectory(root, slug), /Invalid import package slug/);
    }
  } finally {
    rmSync(root, { recursive: true, force: true });
  }
});

test("ownership audit rejects duplicate rows across nested packages", () => {
  const root = mkdtempSync(path.join(tmpdir(), "eralens-ownership-"));
  try {
    for (const slug of ["flat", "period/qi"]) {
      const dir = path.join(root, slug);
      mkdirSync(dir, { recursive: true });
      writeFileSync(path.join(dir, "cache.json"), JSON.stringify({ persons: [{ id: "same-person" }] }));
    }
    assert.throws(() => auditPackageOwnership(root), /persons same-person: flat\[0\], period\/qi\[0\]/);
  } finally {
    rmSync(root, { recursive: true, force: true });
  }
});
