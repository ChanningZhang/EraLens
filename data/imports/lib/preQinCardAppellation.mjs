/**
 * Pre-Qin card primary uses stored posthumous_name / preferred_appellation.
 * Titles still carry 国名 (齐桓公, 吴王夫差); this helper derives the body
 * from the dynasty's own 国号 so runtime does not keep a state-name list.
 *
 * 齐王建 → 王建; 中山王厝 → 王厝; 吴王夫差 → 夫差; 楚若敖 → 若敖; 夏禹 → 禹.
 */

/**
 * @param {string} title
 * @param {string | null | undefined} stateName dynasty 国号 (齐 / 中山 / 夏)
 * @returns {string | null} card body without 国名, or null if title has no prefix
 */
export function preQinRegnalCardName(title, stateName) {
  if (!title || !stateName || !title.startsWith(stateName)) return null;
  const stripped = title.slice(stateName.length);
  if (!stripped) return null;

  const rank = stripped.match(/^([侯王伯])(.+)$/);
  if (!rank) return stripped;

  const body = rank[2];
  if (/^.{1,2}[公王]$/.test(body)) return stripped;
  if (body.length === 1) return stripped;
  return body;
}
