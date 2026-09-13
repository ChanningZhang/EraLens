/**
 * When computing "国君记载缺" gaps for a dynasty lane, also count reigns from
 * related dynasties as coverage. Used when a short interregnum (e.g. 武周)
 * is modeled as a separate dynasty but still represents continuous rule.
 */
export const REIGN_GAP_COVERAGE_FROM: Readonly<Record<string, readonly string[]>> = {
  tang: ["zhou-wu"],
};
