import { createPlatformSettings } from "@eralens/data-access";

const DETAIL_WIDTH_KEY = "eralens.detailWidth";
const settings = createPlatformSettings();

export async function loadDetailWidth(): Promise<number | null> {
  const raw = await settings.get(DETAIL_WIDTH_KEY);
  const width = raw == null ? NaN : Number(raw);
  return Number.isFinite(width) ? width : null;
}

export async function saveDetailWidth(width: number): Promise<void> {
  await settings.set(DETAIL_WIDTH_KEY, String(width));
}
