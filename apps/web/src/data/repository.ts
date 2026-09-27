import { closePlatformRepository, createPlatformRepository } from "@eralens/data-access";
import type { TimelineRepository } from "@eralens/data-access";
export type { TimelineRepository, TimelineQuery } from "@eralens/data-access";

let repositoryPromise: Promise<TimelineRepository> | null = null;

async function createRepository(): Promise<TimelineRepository> {
  const source = import.meta.env.VITE_DATA_SOURCE;
  const mockRepository = source === "mock" ? (await import("./mock/repository")).mockRepository : undefined;
  return createPlatformRepository({
    source,
    apiBase: import.meta.env.VITE_API_BASE ?? "/api",
    mockRepository,
  });
}

export function getRepository(): Promise<TimelineRepository> {
  repositoryPromise ??= createRepository();
  return repositoryPromise;
}

export async function closeRepositoryForContentUpdate(): Promise<void> {
  await closePlatformRepository();
  repositoryPromise = null;
}
