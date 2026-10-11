import { HttpTimelineRepository } from "./httpRepository";
import { SqliteTimelineRepository } from "./sqliteRepository";
import { createPlatformSettings } from "./platformSettings";
import type { EraLensNativeBridge, TimelineRepository } from "./repository";

let nativeRepository: SqliteTimelineRepository | null = null;

export async function closePlatformRepository(): Promise<void> {
  const repository = nativeRepository;
  nativeRepository = null;
  if (repository) await repository.close();
}

export function createPlatformRepository(options: {
  apiBase?: string;
  source?: string;
  mockRepository?: TimelineRepository;
  nativeBridge?: EraLensNativeBridge;
} = {}): TimelineRepository {
  if (options.source === "mock" && options.mockRepository) return options.mockRepository;
  if (options.source === "native") {
    const bridge = options.nativeBridge ?? (typeof window === "undefined" ? undefined : window.eralensNative);
    if (!bridge) throw new Error("EraLens 原生桥接不可用，无法打开离线数据库。");
    if (bridge.protocolVersion !== 1 || !["ios", "mac"].includes(bridge.platform)) {
      throw new Error("EraLens 原生桥接版本不兼容，请重新安装应用。");
    }
    if (!nativeRepository) {
      nativeRepository = new SqliteTimelineRepository({
        async open() {
          return {
            query: (sql, values = []) => bridge.query(sql, values),
            close: () => bridge.closeDatabase(),
          };
        },
      }, createPlatformSettings(bridge));
    }
    return nativeRepository;
  }
  if (options.source === "mock") throw new Error("Mock repository must be supplied by the web application.");
  return new HttpTimelineRepository(options.apiBase);
}
