#!/usr/bin/env node
import { readFileSync, writeFileSync } from "node:fs";

const file = new URL("../src/emperorAppellation.test.ts", import.meta.url);
let body = readFileSync(file, "utf8");

const header = `import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import {
  buildPreQinClanContext,
  type PersonDisplayContext,
  resolveEmperorAppellation as resolveEmperorAppellationBase,
  resolveReignCardGivenName as resolveReignCardGivenNameBase,
  resolveReignCardLabel as resolveReignCardLabelBase,
  resolveReignCardMeta as resolveReignCardMetaBase,
  resolveReignDetailFacts as resolveReignDetailFactsBase,
  resolveReignDetailSubtitle as resolveReignDetailSubtitleBase,
  resolveReignPrimaryLabel as resolveReignPrimaryLabelBase,
  stripAncestralXing,
  usesPreQinCardLayout,
} from "./emperorAppellation";

type SourceOverrides = Partial<Reign> & {
  posthumousName?: string;
  templeName?: string;
};

const personByReign = new WeakMap<Reign, PersonDisplayContext>();

function mergePersonContext(
  reign: Reign,
  personContext?: PersonDisplayContext | null,
): PersonDisplayContext | undefined {
  const stored = personByReign.get(reign);
  if (!stored && !personContext) return undefined;
  return { ...personContext, ...stored };
}

function source(overrides: SourceOverrides = {}) {
  const { posthumousName, templeName, ...reignOverrides } = overrides;
  const reign: Reign = {
    start: { year: 1, month: 1 },
    end: { year: 1, month: 12 },
    title: "皇帝",
    eraNames: [],
    preferredAppellation: undefined,
    ...reignOverrides,
  };
  if (posthumousName || templeName) {
    personByReign.set(reign, {
      ...(posthumousName ? { posthumousNames: [posthumousName] } : {}),
      ...(templeName ? { templeNames: [templeName] } : {}),
    });
  }
  return reign;
}

function resolveEmperorAppellation(
  reign: Reign,
  personContext?: PersonDisplayContext | null,
) {
  return resolveEmperorAppellationBase(reign, mergePersonContext(reign, personContext));
}

function resolveReignPrimaryLabel(
  reign: Reign,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignPrimaryLabelBase(
    reign,
    personName,
    mergePersonContext(reign, personContext),
  );
}

function resolveReignCardLabel(
  reign: Reign,
  personName?: string | null,
  options?: { cardWidthPx?: number; clan?: PersonDisplayContext | null },
) {
  return resolveReignCardLabelBase(reign, personName, {
    ...options,
    clan: mergePersonContext(reign, options?.clan),
  });
}

function resolveReignCardGivenName(
  reign: Reign,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignCardGivenNameBase(
    reign,
    personName,
    mergePersonContext(reign, personContext),
  );
}

function resolveReignCardMeta(
  reign: Reign,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignCardMetaBase(
    reign,
    personName,
    mergePersonContext(reign, personContext),
  );
}

function resolveReignDetailSubtitle(
  reign: Reign,
  dynastyName?: string | null,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignDetailSubtitleBase(
    reign,
    dynastyName,
    personName,
    mergePersonContext(reign, personContext),
  );
}

function resolveReignDetailFacts(
  reign: Reign,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignDetailFactsBase(
    reign,
    personName,
    mergePersonContext(reign, personContext),
  );
}

`;

function convertEraNames(text) {
  const marker = 'eraNames: [';
  let out = "";
  let i = 0;
  while (i < text.length) {
    const idx = text.indexOf(marker, i);
    if (idx === -1) {
      out += text.slice(i);
      break;
    }
    out += text.slice(i, idx);
    const arrayStart = idx + marker.length - 1;
    let depth = 0;
    let j = arrayStart;
    for (; j < text.length; j++) {
      const ch = text[j];
      if (ch === "[") depth++;
      else if (ch === "]") {
        depth--;
        if (depth === 0) break;
      }
    }
    const arrayInner = text.slice(arrayStart + 1, j);
    const tail = text.slice(j + 1);
    const castMatch = tail.match(/^\s*as\s*Reign\["eraNames"\]/);
    if (!castMatch || !arrayInner.includes("name:")) {
      out += text.slice(idx, j + 1);
      i = j + 1;
      continue;
    }
    const names = [...arrayInner.matchAll(/name:\s*"((?:\\.|[^"\\])*)"/g)].map(
      (m) => m[1].replace(/\\"/g, '"'),
    );
    out += `eraNames: ${JSON.stringify(names)}`;
    i = j + 1 + castMatch[0].length;
  }
  return out;
}

const bodyStart = body.indexOf('describe("resolveEmperorAppellation"');
if (bodyStart === -1) throw new Error("describe block not found");
body = convertEraNames(body.slice(bodyStart));

writeFileSync(file, header + body);
console.log("fixed", file.pathname);
