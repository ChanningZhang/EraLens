/**
 * Derive preferred_appellation when a generator wants to persist it.
 * Runtime display ignores non-regnal preferred values; see emperorAppellation.ts.
 */

import { MING_QING_START_YEAR, TEMPLE_ERA_START_YEAR } from "./appellationPolicy.mjs";

const REGIME_NAME_FINAL =
  /[齐晋楚燕宋鲁卫郑曹吴越韩赵魏秦汉夏唐隋梁陈周闽元辽金明清蜀]$/;

function isDynasticEmperorTitle(title) {
  if (!title || title === "皇帝" || title === "始皇帝") return false;
  if (!/^[\u4e00-\u9fff]{2,6}帝$/.test(title)) return false;
  const stem = title.slice(0, -1);
  if (stem.length <= 2 && REGIME_NAME_FINAL.test(stem)) return false;
  return true;
}

function templeDisplayName(_title, templeName) {
  return templeName;
}

function posthumousDisplayName(_title, posthumousName) {
  return posthumousName;
}

function resolvePosthumousAppellation({ title, posthumous, temple }) {
  if (posthumous) {
    return {
      kind: "posthumous",
      name: posthumousDisplayName(title, posthumous),
    };
  }
  if (isDynasticEmperorTitle(title)) {
    return { kind: "posthumous", name: title };
  }
  return null;
}

function resolveTempleAppellation({ title, temple }) {
  if (!temple) return null;
  return {
    kind: "temple",
    name: templeDisplayName(title, temple),
  };
}

export function defaultPreferredAppellation({
  title,
  posthumous,
  temple,
  startYear,
  eraNames = [],
}) {
  const eraName = eraNames[0]?.name;

  if (startYear >= MING_QING_START_YEAR && eraName) {
    return { kind: "era", name: eraName };
  }
  if (startYear >= TEMPLE_ERA_START_YEAR) {
    const templeAppellation = resolveTempleAppellation({ title, temple });
    if (templeAppellation) return templeAppellation;
  }

  const posthumousAppellation = resolvePosthumousAppellation({
    title,
    posthumous,
    temple,
  });
  if (posthumousAppellation) return posthumousAppellation;

  const templeAppellation = resolveTempleAppellation({ title, temple });
  if (templeAppellation) return templeAppellation;

  if (eraName) {
    return { kind: "era", name: eraName };
  }
  return { kind: "regnal", name: title };
}
