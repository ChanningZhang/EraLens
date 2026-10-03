import { keepPreviousData, queryOptions } from "@tanstack/react-query";
import type { EntityRef } from "@eralens/shared";
import { getRepository } from "@/data/repository";

export function entityDetailQueryOptions(selected: EntityRef | null, focusReignId: string | null) {
  return queryOptions({
    queryKey: ["entity", selected?.type, selected?.id, focusReignId],
    queryFn: async () => {
      if (!selected) throw new Error("No selection");
      const repo = await getRepository();
      const detail = await repo.getEntity(
        selected,
        selected.type === "person"
          ? { focusReignId: focusReignId ?? undefined }
          : undefined,
      );
      // Keep the displayed entity and its navigation context together while
      // another selection loads, including another reign of the same person.
      return { detail, selected, focusReignId };
    },
    enabled: Boolean(selected),
    placeholderData: keepPreviousData,
  });
}
