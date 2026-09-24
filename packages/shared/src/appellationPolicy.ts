/**
 * Ming/Qing card small text uses the first era name when reign.title is empty.
 * A nonempty reign.title remains the explicit, higher-priority card label.
 */
export const MING_QING_START_YEAR = 1368;

/** Tang through Yuan cards conventionally show temple names. */
export const TEMPLE_ERA_START_YEAR = 618;

/**
 * First year of imperial naming (始皇帝). Reigns that start earlier use the
 * pre-Qin card layout: appellation as the primary line, given name as meta.
 */
export const PRE_IMPERIAL_START_YEAR = -221;
