#!/usr/bin/env node
/**
 * One-off migrator: reign posthumous/temple + era object arrays → person ctx + string[].
 */
import { readFileSync, writeFileSync } from "node:fs";

const files = process.argv.slice(2);
if (!files.length) {
  console.error("Usage: node migrate-appellation-tests.mjs <files...>");
  process.exit(1);
}

function parseStringProp(body, key) {
  const re = new RegExp(`${key}:\\s*"((?:\\\\.|[^"\\\\])*)"`);
  const m = body.match(re);
  return m ? m[1].replace(/\\"/g, '"') : undefined;
}

function stripProp(body, key) {
  return body
    .replace(new RegExp(`\\n\\s*${key}:\\s*"[^"]*",?`, "g"), "")
    .replace(new RegExp(`\\n\\s*${key}:\\s*undefined,?`, "g"), "");
}

function convertEraNames(body) {
  return body.replace(
    /eraNames:\s*\[([\s\S]*?)\]\s*as\s*Reign\["eraNames"\]/g,
    (_, inner) => {
      const names = [...inner.matchAll(/name:\s*"((?:\\.|[^"\\])*)"/g)].map((m) =>
        m[1].replace(/\\"/g, '"'),
      );
      return `eraNames: ${JSON.stringify(names)}`;
    },
  );
}

function convertEraObjects(body) {
  return body.replace(
    /eraNames:\s*\[\s*\{\s*name:\s*"([^"]+)"[^}\]]*\}(?:\s*,\s*\{\s*name:\s*"([^"]+)"[^}\]]*\})*\s*\]/g,
    (match) => {
      const names = [...match.matchAll(/name:\s*"((?:\\.|[^"\\])*)"/g)].map((m) =>
        m[1].replace(/\\"/g, '"'),
      );
      return `eraNames: ${JSON.stringify(names)}`;
    },
  );
}

function personCtxExpr(posthumous, temple) {
  const parts = [];
  if (posthumous) parts.push(`posthumousNames: ${JSON.stringify([posthumous])}`);
  if (temple) parts.push(`templeNames: ${JSON.stringify([temple])}`);
  if (!parts.length) return null;
  return `personCtx({ ${parts.join(", ")} })`;
}

function mergeClanExpr(clanExpr, personExpr) {
  if (!personExpr) return clanExpr;
  const m = clanExpr.match(
    /buildPreQinClanContext\(\s*null\s*,\s*(\{[\s\S]*?\})\s*\)/,
  );
  if (m) {
    return `buildPreQinClanContext(${personExpr.replace(/^personCtx\(/, "({ ").replace(/\)$/, " })")}, ${m[1]})`.replace(
      "({ {",
      "({",
    );
  }
  if (clanExpr === "clan") {
    return `{ ...clan, ...${personExpr} }`;
  }
  return `{ ...${clanExpr}, ...${personExpr} }`;
}

function findMatchingParen(text, openIdx) {
  let depth = 0;
  for (let i = openIdx; i < text.length; i++) {
    const ch = text[i];
    if (ch === "(") depth++;
    else if (ch === ")") {
      depth--;
      if (depth === 0) return i;
    }
  }
  return -1;
}

function findSourceCall(text, startIdx) {
  const idx = text.indexOf("source(", startIdx);
  if (idx === -1) return null;
  const open = idx + "source".length;
  const close = findMatchingParen(text, open);
  if (close === -1) return null;
  const inner = text.slice(open + 1, close);
  if (!inner.trim().startsWith("{")) return findSourceCall(text, close + 1);
  return { start: idx, open: open, close, inner };
}

const FN_WITH_PERSON = [
  "resolveEmperorAppellation",
  "resolveReignPrimaryLabel",
  "resolveReignCardLabel",
  "resolveReignCardGivenName",
  "resolveReignCardMeta",
  "resolveReignDetailSubtitle",
  "resolveReignDetailFacts",
  "resolveReignRelatedSubtitle",
];

function transformCall(text, fnName, callStart) {
  const open = text.indexOf("(", callStart + fnName.length);
  const close = findMatchingParen(text, open);
  if (close === -1) return text;

  const argsText = text.slice(open + 1, close);
  const src = findSourceCall(argsText, 0);
  if (!src) return text;

  const posthumous = parseStringProp(src.inner, "posthumousName");
  const temple = parseStringProp(src.inner, "templeName");
  const personExpr = personCtxExpr(posthumous, temple);
  if (!personExpr) return text;

  let newInner = convertEraNames(convertEraObjects(stripProp(stripProp(src.inner, "posthumousName"), "templeName")));
  const newSource = `source({${newInner}})`;

  let rest = argsText.slice(src.close + 1).trim();
  if (rest.startsWith(",")) rest = rest.slice(1).trim();

  let newArgs;
  if (!rest) {
    newArgs = `${newSource}, ${personExpr}`;
  } else {
    const restParts = splitTopLevelArgs(rest);
    const last = restParts[restParts.length - 1]?.trim();
    const hasClan =
      last === "clan" ||
      last?.startsWith("buildPreQinClanContext") ||
      last?.startsWith("{ clan") ||
      last?.includes("clan");
    if (hasClan && fnName !== "resolveReignDetailFacts") {
      restParts[restParts.length - 1] = mergeClanExpr(last, personExpr);
      newArgs = `${newSource}, ${restParts.join(", ")}`;
    } else if (fnName === "resolveReignDetailFacts" && restParts.length === 0) {
      newArgs = `${newSource}, undefined, ${personExpr}`;
    } else if (fnName === "resolveReignDetailFacts" && restParts.length === 1) {
      newArgs = `${newSource}, ${restParts[0]}, ${personExpr}`;
    } else {
      newArgs = `${newSource}, ${rest}, ${personExpr}`;
    }
  }

  return text.slice(0, callStart) + fnName + "(" + newArgs + ")" + text.slice(close + 1);
}

function splitTopLevelArgs(s) {
  const parts = [];
  let cur = "";
  let depth = 0;
  for (let i = 0; i < s.length; i++) {
    const ch = s[i];
    if (ch === "(" || ch === "{" || ch === "[") depth++;
    if (ch === ")" || ch === "}" || ch === "]") depth--;
    if (ch === "," && depth === 0) {
      parts.push(cur.trim());
      cur = "";
    } else {
      cur += ch;
    }
  }
  if (cur.trim()) parts.push(cur.trim());
  return parts;
}

function transformConstReign(text) {
  return text.replace(
    /const\s+(\w+)\s*=\s*source\(\{([\s\S]*?)\}\);/g,
    (full, varName, body) => {
      const posthumous = parseStringProp(body, "posthumousName");
      const temple = parseStringProp(body, "templeName");
      if (!posthumous && !temple) {
        return `const ${varName} = source({${convertEraNames(convertEraObjects(body))}});`;
      }
      let newBody = convertEraNames(convertEraObjects(stripProp(stripProp(body, "posthumousName"), "templeName")));
      const personVar = `${varName}Person`;
      const personExpr = personCtxExpr(posthumous, temple);
      return `const ${varName} = source({${newBody}});\n    const ${personVar} = ${personExpr};`;
    },
  );
}

function patchConstReignUsages(text) {
  return text.replace(
    /resolve(Reign\w+|EmperorAppellation)\(\s*(\w+Reign|\w+)\s*,/g,
    (match, fn, varName) => {
      if (text.includes(`const ${varName}Person =`)) {
        return match.replace(`${varName},`, `${varName}, undefined, ${varName}Person,`).replace(", undefined, undefined,", ", undefined,");
      }
      return match;
    },
  );
}

function transformFile(path) {
  let text = readFileSync(path, "utf8");
  const orig = text;

  if (path.endsWith("emperorAppellation.test.ts")) {
    if (!text.includes("function personCtx")) {
      text = text.replace(
        'import type { Reign } from "./schema";',
        'import type { Reign } from "./schema";\nimport type { PersonDisplayContext } from "./emperorAppellation";',
      );
      text = text.replace(
        /function source\(overrides: Partial<Reign>\) \{\s*return \{[\s\S]*?\};\s*\}/,
        `function personCtx(overrides: Partial<PersonDisplayContext>): PersonDisplayContext {
  return { ...overrides };
}

function source(overrides: Partial<Reign>) {
  return {
    start: { year: 1, month: 1 },
    end: { year: 1, month: 12 },
    title: "皇帝",
    eraNames: [],
    ...overrides,
  };
}`,
      );
    }
  }

  text = convertEraNames(text);
  text = convertEraObjects(text);

  if (path.endsWith("emperorAppellation.test.ts")) {
    for (const fn of FN_WITH_PERSON) {
      let idx = 0;
      while ((idx = text.indexOf(fn + "(", idx)) !== -1) {
        const next = transformCall(text, fn, idx);
        if (next === text) {
          idx += fn.length + 1;
        } else {
          text = next;
          idx += fn.length + 1;
        }
      }
    }
    text = transformConstReign(text);
    // Fix const reign usages
    text = text.replace(
      /const (\w+) = source\(\{([\s\S]*?)\}\);\n    const \1Person = personCtx\([^)]+\);\n    const clan = buildPreQinClanContext\(null, ([^)]+)\);/g,
      (m, v, body, dynasty) =>
        `const ${v} = source({${body}});\n    const ${v}Person = personCtx({ posthumousNames: ${JSON.stringify([parseStringProp(body, "posthumousName")].filter(Boolean))} });\n    const clan = buildPreQinClanContext(${v}Person, ${dynasty});`.replace(
          'posthumousNames: [undefined]',
          "",
        ),
    );
    // simpler const reign + clan pattern
    text = text.replace(
      /(const reign = source\(\{[\s\S]*?\}\);\n    const reignPerson = personCtx\(\{ posthumousNames: \["([^"]+)"\] \}\);)\n    const clan = buildPreQinClanContext\(null,/g,
      '$1\n    const clan = buildPreQinClanContext(reignPerson,',
    );
    text = text.replace(
      /resolveReignPrimaryLabel\(reign, "([^"]+)", clan\)/g,
      'resolveReignPrimaryLabel(reign, "$1", clan)',
    );
    text = text.replace(
      /resolveReignDetailFacts\(\s*(\w+Reign|\w+),\s*\)/g,
      "resolveReignDetailFacts($1, undefined, $1Person)",
    );
    text = text.replace(
      /resolveReignDetailFacts\(\s*(\w+Reign|\w+),\s*undefined,\s*\1Person,\s*\)/g,
      "resolveReignDetailFacts($1, undefined, $1Person)",
    );
    text = text.replace(
      /resolveReignDetailSubtitle\((\w+Reign), "([^"]+)", "([^"]+)"\)/g,
      'resolveReignDetailSubtitle($1, "$2", "$3", $1Person)',
    );
  } else {
    text = text.replace(/posthumousName:\s*"[^"]*",?\n?\s*/g, "");
    text = text.replace(/templeName:\s*"[^"]*",?\n?\s*/g, "");
    text = text.replace(/templeName:\s*undefined,?\n?\s*/g, "");
  }

  if (text !== orig) {
    writeFileSync(path, text);
    console.log("updated", path);
  }
}

for (const file of files) transformFile(file);
