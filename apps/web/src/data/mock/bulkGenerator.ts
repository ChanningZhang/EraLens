import { absMonth, type Dynasty, type Reign } from "@eralens/shared";

/** Synthetic bulk data for performance validation (not shown in UI labels). */
export function generateBulkReigns(count = 2200): Reign[] {
  const reigns: Reign[] = [];
  const dynastyCount = 80;
  const baseYear = -200;
  const spanYears = 1800;

  for (let i = 0; i < count; i++) {
    const dynastyIndex = i % dynastyCount;
    const startYear = baseYear + Math.floor((i / count) * spanYears);
    const endYear = startYear + 2 + (i % 7);
    const startAbs = absMonth(startYear, 1);
    const endAbs = absMonth(endYear, 12);
    reigns.push({
      id: `bulk-reign-${i}`,
      dynastyId: `bulk-dynasty-${dynastyIndex}`,
      personId: `bulk-person-${i}`,
      title: `君主${i}`,
      eraNames: [],
      start: { year: startYear, month: 1 },
      end: { year: endYear, month: 12 },
      startAbs,
      endAbs,
      precision: "year",
      isInformalMonarch: false,
    });
  }
  return reigns;
}

export function generateBulkDynasties(count = 80): Dynasty[] {
  const dynasties: Dynasty[] = [];
  const baseYear = -200;
  const spanYears = 1800;

  for (let i = 0; i < count; i++) {
    const startYear = baseYear + Math.floor((i / count) * spanYears);
    const endYear = startYear + 15 + (i % 20);
    dynasties.push({
      id: `bulk-dynasty-${i}`,
      name: `测试王朝${i}`,
      altNames: [],
      scope: "cn",
      region: "east_asia",
      start: { year: startYear, month: 1 },
      end: { year: endYear, month: 12 },
      startAbs: absMonth(startYear, 1),
      endAbs: absMonth(endYear, 12),
      precision: "year",
    });
  }
  return dynasties;
}
