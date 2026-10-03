import { QueryClient, QueryObserver } from "@tanstack/react-query";
import type { EntityDetail, EntityRef } from "@eralens/shared";
import { afterEach, describe, expect, it, vi } from "vitest";
import { entityDetailQueryOptions } from "./entityDetailQuery";

const getEntity = vi.hoisted(() => vi.fn());
vi.mock("@/data/repository", () => ({
  getRepository: async () => ({ getEntity }),
}));

const cleanups: Array<() => void> = [];
afterEach(() => {
  cleanups.splice(0).forEach((cleanup) => cleanup());
  getEntity.mockReset();
});

function detail(id: string): EntityDetail {
  return {
    ref: { type: "person", id }, title: id, dynastyId: `dynasty-${id}`,
    facts: [{ label: "在位", value: id }], summary: `summary-${id}`,
    related: [], capitalTenures: [], links: [],
  };
}

function deferred() {
  let resolve!: (value: EntityDetail) => void;
  let reject!: (reason: Error) => void;
  const promise = new Promise<EntityDetail>((yes, no) => { resolve = yes; reject = no; });
  return { promise, resolve, reject };
}

async function openPanel() {
  const client = new QueryClient({ defaultOptions: { queries: { retry: false, staleTime: Infinity } } });
  getEntity.mockResolvedValueOnce(detail("a"));
  const observer = new QueryObserver(client, entityDetailQueryOptions({ type: "person", id: "a" }, "reign-a"));
  const unsubscribe = observer.subscribe(() => {});
  cleanups.push(() => { unsubscribe(); client.clear(); });
  await vi.waitFor(() => expect(observer.getCurrentResult().data?.detail.title).toBe("a"));
  const select = (id: string, focus = `reign-${id}`) => observer.setOptions(
    entityDetailQueryOptions({ type: "person", id }, focus),
  );
  return { observer, select };
}

describe("detail changes while the drawer remains open", () => {
  it("keeps the complete previous detail and context until an uncached selection is ready", async () => {
    const { observer, select } = await openPanel();
    const next = deferred();
    getEntity.mockReturnValueOnce(next.promise);
    select("b");
    const pending = observer.getCurrentResult();
    expect(pending.isLoading).toBe(false);
    expect(pending.isPlaceholderData).toBe(true);
    expect(pending.data).toEqual({ detail: detail("a"), selected: { type: "person", id: "a" }, focusReignId: "reign-a" });
    next.resolve(detail("b"));
    await vi.waitFor(() => expect(observer.getCurrentResult().data?.detail.title).toBe("b"));
    expect(observer.getCurrentResult().isPlaceholderData).toBe(false);
    expect(observer.getCurrentResult().data?.focusReignId).toBe("reign-b");
  });

  it("shows a cached selection immediately without placeholder content", async () => {
    const { observer, select } = await openPanel();
    getEntity.mockResolvedValueOnce(detail("b"));
    select("b");
    await vi.waitFor(() => expect(observer.getCurrentResult().data?.detail.title).toBe("b"));
    select("a");
    expect(observer.getCurrentResult().data?.detail.title).toBe("a");
    expect(observer.getCurrentResult().isPlaceholderData).toBe(false);
    expect(getEntity).toHaveBeenCalledTimes(2);
  });

  it("preserves the focused reign when switching between reigns of the same person", async () => {
    const { observer, select } = await openPanel();
    const next = deferred();
    getEntity.mockReturnValueOnce(next.promise);
    select("a", "reign-a-second");
    expect(observer.getCurrentResult().data?.focusReignId).toBe("reign-a");
    next.resolve({ ...detail("a"), subtitle: "second reign" });
    await vi.waitFor(() => expect(observer.getCurrentResult().data?.focusReignId).toBe("reign-a-second"));
    expect(getEntity).toHaveBeenLastCalledWith({ type: "person", id: "a" }, { focusReignId: "reign-a-second" });
  });

  it("does not let a slow intermediate selection overwrite the latest selection", async () => {
    const { observer, select } = await openPanel();
    const middle = deferred();
    const latest = deferred();
    getEntity.mockImplementation((ref: EntityRef) => ref.id === "b" ? middle.promise : latest.promise);
    select("b");
    await vi.waitFor(() => expect(getEntity).toHaveBeenCalledWith({ type: "person", id: "b" }, { focusReignId: "reign-b" }));
    select("c");
    expect(observer.getCurrentResult().data?.detail.title).toBe("a");
    latest.resolve(detail("c"));
    await vi.waitFor(() => expect(observer.getCurrentResult().data?.detail.title).toBe("c"));
    middle.resolve(detail("b"));
    await middle.promise;
    expect(observer.getCurrentResult().data?.detail.title).toBe("c");
  });

  it("reports a failed selection instead of presenting the previous detail as its result", async () => {
    const { observer, select } = await openPanel();
    getEntity.mockRejectedValueOnce(new Error("unavailable"));
    select("b");
    await vi.waitFor(() => expect(observer.getCurrentResult().isError).toBe(true));
    expect(observer.getCurrentResult().data).toBeUndefined();
    select("a");
    expect(observer.getCurrentResult().data?.detail.title).toBe("a");
  });
});
