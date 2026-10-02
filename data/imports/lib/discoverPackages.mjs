import { readdirSync } from "node:fs";
import path from "node:path";

/** Return stable, root-relative package paths, including nested packages.
 * Symlink directories are deliberately not followed.
 */
export function discoverPackages(root, marker = "cache.json") {
  const packages = [];
  function visit(directory, relative) {
    const entries = readdirSync(directory, { withFileTypes: true });
    if (relative && entries.some((entry) => entry.isFile() && entry.name === marker)) {
      packages.push(relative);
    }
    for (const entry of entries) {
      if (!entry.isDirectory() || entry.name.startsWith(".")) continue;
      visit(path.join(directory, entry.name), relative ? `${relative}/${entry.name}` : entry.name);
    }
  }
  visit(root, "");
  return packages.sort();
}

/** Accept nested package paths without allowing traversal outside imports. */
export function resolvePackageDirectory(root, slug) {
  if (!slug || slug.split("/").some((part) => !part || part.startsWith(".") || part.includes("\\"))) {
    throw new Error(`Invalid import package slug: ${slug}`);
  }
  const directory = path.resolve(root, slug);
  if (!directory.startsWith(`${path.resolve(root)}${path.sep}`)) {
    throw new Error(`Invalid import package slug: ${slug}`);
  }
  return directory;
}
