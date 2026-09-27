import { Capacitor } from "@capacitor/core";
import { EraLensNative } from "@eralens/data-access";
export type { MobileContentInfo } from "@eralens/data-access";

export const isNativeApp = () => Capacitor.isNativePlatform();
export const getMobileContentInfo = () => EraLensNative.getContentInfo();
export const checkMobileDataUpdate = () => EraLensNative.checkForUpdate();
export const installMobileDataUpdate = () => EraLensNative.installPendingUpdate();

export async function openExternalSource(url: string): Promise<void> {
  if (Capacitor.isNativePlatform()) {
    await EraLensNative.openExternal({ url });
    return;
  }
  window.open(url, "_blank", "noopener,noreferrer");
}
