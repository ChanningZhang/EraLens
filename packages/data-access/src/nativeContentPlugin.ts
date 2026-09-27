import { registerPlugin } from "@capacitor/core";

export interface MobileContentInfo {
  datasetVersion: string;
  schemaVersion: number;
  contractVersion: number;
  sourceGitSha: string;
  builtAt: string;
  configured: boolean;
}

export interface UpdateCheckResult {
  configured: boolean;
  available: boolean;
  datasetVersion?: string;
  message: string;
}

export interface EraLensNativePlugin {
  getContentInfo(): Promise<MobileContentInfo>;
  prepareContentDatabase(): Promise<{ datasetVersion: string; recovered: boolean }>;
  checkForUpdate(): Promise<UpdateCheckResult>;
  installPendingUpdate(): Promise<{ datasetVersion: string; message: string }>;
  openExternal(options: { url: string }): Promise<void>;
}

export const EraLensNative = registerPlugin<EraLensNativePlugin>("EraLensNative");
