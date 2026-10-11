import type { EraLensNativeBridge } from "@eralens/data-access";

export const isNativeApp = () => import.meta.env.VITE_PLATFORM === "ios" || import.meta.env.VITE_PLATFORM === "mac";

export function getNativeBridge(): EraLensNativeBridge {
  const bridge = window.eralensNative;
  if (!bridge) throw new Error("EraLens 原生桥接不可用");
  if (bridge.protocolVersion !== 1 || bridge.platform !== import.meta.env.VITE_PLATFORM) {
    throw new Error("EraLens 原生桥接版本不兼容，请重新安装应用");
  }
  return bridge;
}

export async function openExternalSource(url: string): Promise<void> {
  if (isNativeApp()) {
    await getNativeBridge().openExternal({ url });
    return;
  }
  window.open(url, "_blank", "noopener,noreferrer");
}
