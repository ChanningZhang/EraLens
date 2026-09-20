import { describe, expect, it } from "vitest";
import { CHINA_MAP_BOUNDS, projectGcj02 } from "./chinaMapProjection";

describe("projectGcj02", () => {
  const width = 800;
  const height = 600;
  const padding = 16;

  it("places Xi'an inside the padded viewport", () => {
    const point = projectGcj02(108.939645, 34.343207, width, height, padding);
    expect(point.x).toBeGreaterThan(padding);
    expect(point.x).toBeLessThan(width - padding);
    expect(point.y).toBeGreaterThan(padding);
    expect(point.y).toBeLessThan(height - padding);
  });

  it("maps higher latitude to smaller y", () => {
    const north = projectGcj02(110, 50, width, height, padding);
    const south = projectGcj02(110, 25, width, height, padding);
    expect(north.y).toBeLessThan(south.y);
  });

  it("maps eastern longitude to larger x", () => {
    const west = projectGcj02(80, 35, width, height, padding);
    const east = projectGcj02(120, 35, width, height, padding);
    expect(east.x).toBeGreaterThan(west.x);
  });

  it("respects envelope corners inside the fitted map box", () => {
    const sw = projectGcj02(CHINA_MAP_BOUNDS.minLng, CHINA_MAP_BOUNDS.minLat, width, height, padding);
    const ne = projectGcj02(CHINA_MAP_BOUNDS.maxLng, CHINA_MAP_BOUNDS.maxLat, width, height, padding);
    expect(sw.x).toBeGreaterThanOrEqual(padding);
    expect(sw.y).toBeLessThanOrEqual(height - padding);
    expect(ne.x).toBeLessThanOrEqual(width - padding);
    expect(ne.y).toBeGreaterThanOrEqual(padding);
    expect(ne.x).toBeGreaterThan(sw.x);
    expect(sw.y).toBeGreaterThan(ne.y);
  });
});
