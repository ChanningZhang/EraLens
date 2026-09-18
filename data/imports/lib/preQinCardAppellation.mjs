/**
 * Pre-Qin card primary uses stored posthumous_name / preferred_appellation.
 * Titles still carry 国名 (齐桓公, 吴王夫差); this helper derives the body
 * from the dynasty's own 国号 so runtime does not keep a state-name list.
 *
 * 齐王建 → 王建; 齐侯剡 → 剡; 中山王厝 → 厝; 吴王夫差 → 夫差; 燕王哙 → 哙; 楚若敖 → 若敖; 夏禹 → 禹.
 */

/**
 * @typedef {{ ancestralXing?: string, clanShi?: string }} PreQinClanHint
 */

/**
 * @param {string | null | undefined} personName
 * @param {string} body
 * @param {PreQinClanHint | null | undefined} clan
 */
function personStoredAsXingGivenName(personName, body, clan) {
  const xing = clan?.ancestralXing;
  if (!personName || !xing || !body) return false;
  return personName.startsWith(xing) && personName.slice(xing.length) === body;
}

function personStoredAsShiGivenName(personName, body, clan) {
  const shi = clan?.clanShi;
  if (!personName || !shi || !body) return false;
  return personName.startsWith(shi) && personName.slice(shi.length) === body;
}

/** @param {string | null | undefined} personName */
function personStoredAsBareGivenName(personName, body) {
  return Boolean(personName && body && personName === body);
}

/**
 * @param {string} title
 * @param {string | null | undefined} stateName dynasty 国号 (齐 / 中山 / 夏)
 * @param {string | null | undefined} [personName]
 * @param {PreQinClanHint | null | undefined} [clan]
 * @returns {string | null} card body without 国名, or null if title has no prefix
 */
export function preQinRegnalCardName(title, stateName, personName, clan) {
  if (!title || !stateName || !title.startsWith(stateName)) return null;
  const stripped = title.slice(stateName.length);
  if (!stripped) return null;

  const rank = stripped.match(/^([侯王伯])(.+)$/);
  if (!rank) return stripped;

  const body = rank[2];
  if (/^.{1,2}[公王]$/.test(body)) return stripped;
  if (body.length === 1) {
    if (
      personStoredAsXingGivenName(personName, body, clan) ||
      personStoredAsShiGivenName(personName, body, clan) ||
      personStoredAsBareGivenName(personName, body)
    ) {
      return body;
    }
    return stripped;
  }
  return body;
}
