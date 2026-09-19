/** Parse comma-separated appellation values stored in DB text columns. */
export function parseAppellationCsv(raw?: string | null): string[] {
  if (!raw) return [];
  return raw
    .split(",")
    .map((part) => part.trim())
    .filter(Boolean);
}

/** Serialize appellation values for DB text columns; empty → null. */
export function formatAppellationCsv(values?: string[] | null): string | null {
  if (!values?.length) return null;
  const cleaned = values.map((v) => v.trim()).filter(Boolean);
  return cleaned.length ? cleaned.join(",") : null;
}

/** First value for card display when multiple are stored on a person. */
export function firstAppellation(values?: string[]): string | undefined {
  return values?.find(Boolean);
}
