/**
 * Default preferred_appellation for import scripts.
 * Keep in sync with packages/shared/src/emperorAppellation.ts.
 */

const MING_QING_START_YEAR = 1368;
const TEMPLE_ERA_START_YEAR = 618;

function isDynasticEmperorTitle(title) {
  if (!title || title === "皇帝" || title === "始皇帝") return false;
  return /^[\u4e00-\u9fff]{2,6}帝$/.test(title);
}

function templeDisplayName(title, templeName) {
  if (title && title !== "皇帝" && title.includes(templeName)) {
    return title;
  }
  return title.length > templeName.length ? title : templeName;
}

function posthumousDisplayName(title, posthumousName) {
  if (title && title !== "皇帝") return title;
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
