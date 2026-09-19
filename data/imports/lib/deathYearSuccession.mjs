/**
 * Year-precision sequential succession (逾年改元 / English king-list convention).
 *
 * Death year stays with the predecessor. A multi-year successor that currently
 * starts in that year is moved to the next calendar year.
 *
 * Detection uses each reign's **original** wiki/source years. Do not re-read
 * mutated starts, or a king who already moved onto the death year (秦孝文王)
 * will block the next successor (秦庄襄王) from shifting.
 *
 * Reign objects may use `start`/`end` or `startYear`/`endYear`.
 *
 * Exceptions (keep the shared year):
 * - one-year short reigns (公孙无知、卫戴公)
 * - wiki/sources that say 未逾年改元
 * - concurrent clusters (two+ multi-year reigns sharing a start)
 * - 改元续任 of the same person (魏惠王 / 魏惠成王) — prefer merging those
 *   spans before calling this helper
 */

const DEFAULT_SAME_YEAR_ACCESSION = new Set(["秦灵公", "秦简公", "秦献公"]);

function yearOf(reign, side) {
  if (side === "start") return reign.startYear ?? reign.start;
  return reign.endYear ?? reign.end;
}

function setStart(reign, year) {
  if ("startYear" in reign) reign.startYear = year;
  if ("start" in reign) reign.start = year;
}

function origSpan(orig) {
  return orig.end - orig.start + 1;
}

function samePerson(a, b) {
  if (a.personId && b.personId && a.personId === b.personId) return true;
  const aName = a.personName ?? a.name;
  const bName = b.personName ?? b.name;
  return Boolean(aName && bName && aName === bName);
}

function normalizeDynasty(rulers, sameYearTitles) {
  const sorted = [...rulers].sort(
    (a, b) =>
      yearOf(a, "start") - yearOf(b, "start") ||
      yearOf(a, "end") - yearOf(b, "end") ||
      String(a.personId ?? a.title).localeCompare(String(b.personId ?? b.title)),
  );
  const original = new Map(
    sorted.map((reign) => [
      reign,
      { start: yearOf(reign, "start"), end: yearOf(reign, "end") },
    ]),
  );

  const starts = new Map();
  for (const reign of sorted) {
    const year = original.get(reign).start;
    const list = starts.get(year);
    if (list) list.push(reign);
    else starts.set(year, [reign]);
  }

  function isConcurrentCluster(reign) {
    const orig = original.get(reign);
    const peers = starts.get(orig.start) ?? [];
    const multi = peers.filter((item) => origSpan(original.get(item)) > 1);
    return multi.length > 1 && multi.includes(reign);
  }

  for (const ruler of sorted) {
    const orig = original.get(ruler);
    if (orig.end <= orig.start) continue;
    if (sameYearTitles.has(ruler.title)) continue;
    if (isConcurrentCluster(ruler)) continue;

    const predecessors = sorted.filter((item) => {
      if (item === ruler) return false;
      const other = original.get(item);
      return other.end === orig.start && other.start < orig.start;
    });
    const oneYearPeers = (starts.get(orig.start) ?? []).filter(
      (item) => item !== ruler && origSpan(original.get(item)) === 1,
    );

    let shouldShift = predecessors.length > 0;
    if (shouldShift) {
      const pred = predecessors.sort(
        (a, b) => original.get(b).start - original.get(a).start,
      )[0];
      if (samePerson(pred, ruler)) shouldShift = false;
    }
    if (!shouldShift && oneYearPeers.length > 0) {
      // 卫成公复位与卫君瑕同列前632年：短祚年归一年君，复位段次年起算。
      // 即使同一人的前一段也在该年结束，仍要后移，不能当成魏惠王式改元续任。
      shouldShift = true;
    }
    if (!shouldShift) continue;

    setStart(ruler, orig.start + 1);
    if (yearOf(ruler, "start") > yearOf(ruler, "end")) {
      setStart(ruler, yearOf(ruler, "end"));
    }
  }
}

export function applyDeathYearToPredecessor(rulers, options = {}) {
  const sameYearTitles = new Set([
    ...DEFAULT_SAME_YEAR_ACCESSION,
    ...(options.sameYearAccessionTitles ?? []),
  ]);
  const groups = new Map();
  for (const reign of rulers) {
    const id = reign.dynastyId ?? "_";
    const list = groups.get(id);
    if (list) list.push(reign);
    else groups.set(id, [reign]);
  }
  for (const list of groups.values()) {
    normalizeDynasty(list, sameYearTitles);
  }
  return rulers;
}
