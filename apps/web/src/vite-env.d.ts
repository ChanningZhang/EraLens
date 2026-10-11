/// <reference types="vite/client" />

declare global {
  interface ImportMetaEnv {
    readonly VITE_PLATFORM?: "web" | "ios" | "mac";
    readonly VITE_DATA_SOURCE?: string;
    readonly VITE_API_BASE?: string;
  }
}

declare module "*.svg" {
  const src: string;
  export default src;
}

declare module "*.svg?raw" {
  const src: string;
  export default src;
}
