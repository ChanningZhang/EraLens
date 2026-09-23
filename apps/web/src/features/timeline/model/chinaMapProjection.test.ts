import { describe, expect, it } from "vitest";
import {
  CHINA_MAP_BOUNDS,
  chinaMapGeoAspect,
  chinaMapViewBox,
  projectChinaLatitude,
  projectGcj02,
  resolveChinaMapLayout,
} from "./chinaMapProjection";

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
    const sw = projectGcj02(
      CHINA_MAP_BOUNDS.minLng,
      CHINA_MAP_BOUNDS.minLat,
      width,
      height,
      padding,
    );
    const ne = projectGcj02(
      CHINA_MAP_BOUNDS.maxLng,
      CHINA_MAP_BOUNDS.maxLat,
      width,
      height,
      padding,
    );
    expect(sw.x).toBeGreaterThanOrEqual(padding);
    expect(sw.y).toBeLessThanOrEqual(height - padding);
    expect(ne.x).toBeLessThanOrEqual(width - padding);
    expect(ne.y).toBeGreaterThanOrEqual(padding);
    expect(ne.x).toBeGreaterThan(sw.x);
    expect(sw.y).toBeGreaterThan(ne.y);
  });

  it("uses latitude-corrected aspect ratio (taller than equirectangular)", () => {
    const equirectangularAspect =
      (CHINA_MAP_BOUNDS.maxLng - CHINA_MAP_BOUNDS.minLng) /
      (CHINA_MAP_BOUNDS.maxLat - CHINA_MAP_BOUNDS.minLat);
    expect(chinaMapGeoAspect()).toBeLessThan(equirectangularAspect);
    expect(chinaMapGeoAspect()).toBeGreaterThan(1.3);
  });

  it("keeps viewBox aligned with projected latitude span", () => {
    const minProj = projectChinaLatitude(CHINA_MAP_BOUNDS.minLat);
    const maxProj = projectChinaLatitude(CHINA_MAP_BOUNDS.maxLat);
    expect(chinaMapViewBox()).toBe(
      `${CHINA_MAP_BOUNDS.minLng} ${minProj} ${CHINA_MAP_BOUNDS.maxLng - CHINA_MAP_BOUNDS.minLng} ${maxProj - minProj}`,
    );
  });

  it("anchors the fitted map to the left inset", () => {
    const layout = resolveChinaMapLayout(1400, 600, {
      top: 20,
      right: 24,
      bottom: 28,
      left: 114,
    });

    expect(layout.left).toBe(114);
    expect(1400 - (layout.left + layout.width)).toBeGreaterThan(24);
  });
});
