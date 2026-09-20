/** Import-time modernName rule (eralens-capital-geocode skill); not enforced at API runtime. */

const MUNICIPALITY = /^(?:北京市|上海市|天津市|重庆市)$/;
const PROVINCE_PREFIX = /^.{2,}(?:省|自治区)/;
const FOREIGN = /^.{2,}(?:国|共和国|斯坦)/;

export function isValidCapitalModernName(name) {
  if (MUNICIPALITY.test(name)) return true;
  if (FOREIGN.test(name)) return true;
  return PROVINCE_PREFIX.test(name) && name.length >= 6;
}

export function assertCapitalModernNames(capitals) {
  const invalid = capitals.filter((c) => !isValidCapitalModernName(c.modernName));
  if (invalid.length === 0) return;
  const lines = invalid.map((c) => `  - ${c.id}: ${c.modernName}`);
  throw new Error(
    `Invalid dynasty_capitals modernName (must be 省/自治区/直辖市全称 or 境外):\n${lines.join("\n")}`,
  );
}
