/** GCJ-02 display envelope for contemporary China (mainland + Hainan + Taiwan). */
export const CHINA_MAP_BOUNDS = {
  minLng: 73,
  maxLng: 136,
  minLat: 17,
  maxLat: 54,
} as const;

/** Keep in sync with ChinaMapBackground map box positioning. */
export const CHINA_MAP_INSETS = {
  top: 20,
  right: 24,
  bottom: 28,
  gutterExtra: 12,
} as const;

export const CHINA_MAP_MID_LAT =
  (CHINA_MAP_BOUNDS.minLat + CHINA_MAP_BOUNDS.maxLat) / 2;

/** Compensate equirectangular flattening so China reads naturally on wide screens. */
export const CHINA_MAP_LATITUDE_SCALE = Math.cos(
  (CHINA_MAP_MID_LAT * Math.PI) / 180,
);

export type MapPoint = { x: number; y: number };

export type ChinaMapInsets = {
  top: number;
  right: number;
  bottom: number;
  left: number;
};

export type ChinaMapLayout = {
  left: number;
  top: number;
  width: number;
  height: number;
};

/** Project latitude into display space (must match generate-china-outline.mjs). */
export function projectChinaLatitude(lat: number): number {
  return (
    CHINA_MAP_MID_LAT + (lat - CHINA_MAP_MID_LAT) / CHINA_MAP_LATITUDE_SCALE
  );
}

export function chinaMapProjectedLatSpan(): number {
  const { minLat, maxLat } = CHINA_MAP_BOUNDS;
  return projectChinaLatitude(maxLat) - projectChinaLatitude(minLat);
}

export function chinaMapGeoAspect(): number {
  const { minLng, maxLng } = CHINA_MAP_BOUNDS;
  return (maxLng - minLng) / chinaMapProjectedLatSpan();
}

/** SVG viewBox string; keep in sync with generate-china-outline.mjs. */
export function chinaMapViewBox(): string {
  const { minLng, maxLng, minLat } = CHINA_MAP_BOUNDS;
  const minProjLat = projectChinaLatitude(minLat);
  return `${minLng} ${minProjLat} ${maxLng - minLng} ${chinaMapProjectedLatSpan()}`;
}

export function resolveChinaMapInsets(gutterPx: number): ChinaMapInsets {
  return {
    top: CHINA_MAP_INSETS.top,
    right: CHINA_MAP_INSETS.right,
    bottom: CHINA_MAP_INSETS.bottom,
    left: gutterPx + CHINA_MAP_INSETS.gutterExtra,
  };
}

function normalizeInsets(padding: number | ChinaMapInsets): ChinaMapInsets {
  if (typeof padding === "number") {
    return { top: padding, right: padding, bottom: padding, left: padding };
  }
  return padding;
}

export function resolveChinaMapLayout(
  width: number,
  height: number,
  padding: number | ChinaMapInsets = 16,
): ChinaMapLayout {
  const insets = normalizeInsets(padding);
  const { minLng, maxLng, minLat, maxLat } = CHINA_MAP_BOUNDS;
  const lngSpan = maxLng - minLng;
  const latSpan = projectChinaLatitude(maxLat) - projectChinaLatitude(minLat);
  const geoAspect = lngSpan / latSpan;
  const maxInnerW = Math.max(1, width - insets.left - insets.right);
  const maxInnerH = Math.max(1, height - insets.top - insets.bottom);
  const containerAspect = maxInnerW / maxInnerH;

  let innerW = maxInnerW;
  let innerH = maxInnerH;
  if (containerAspect > geoAspect) {
    innerH = maxInnerH;
    innerW = innerH * geoAspect;
  } else {
    innerW = maxInnerW;
    innerH = innerW / geoAspect;
  }

  // Keep the map anchored to the timeline's left side.  The detail drawer is
  // layered over the right edge of the stage, so centering the map makes the
  // drawer cover the map much earlier than necessary.  The unused horizontal
  // space remains on the right as intentional breathing room.
  return {
    left: insets.left,
    top: insets.top + (maxInnerH - innerH) / 2,
    width: innerW,
    height: innerH,
  };
}

export function projectGcj02(
  lng: number,
  lat: number,
  width: number,
  height: number,
  padding: number | ChinaMapInsets = 16,
): MapPoint {
  const { minLng, maxLng, minLat, maxLat } = CHINA_MAP_BOUNDS;
  const layout = resolveChinaMapLayout(width, height, padding);
  const lngSpan = maxLng - minLng;
  const latSpan = projectChinaLatitude(maxLat) - projectChinaLatitude(minLat);
  const x = layout.left + ((lng - minLng) / lngSpan) * layout.width;
  const y =
    layout.top +
    ((projectChinaLatitude(maxLat) - projectChinaLatitude(lat)) / latSpan) *
      layout.height;
  return { x, y };
}

/** Convert domestic WGS84 event coordinates to the GCJ-02 frame used by the map. */
export function wgs84ToGcj02(lng: number, lat: number): MapPoint {
  if (lng < 72.004 || lng > 137.8347 || lat < 0.8293 || lat > 55.8271) {
    return { x: lng, y: lat };
  }
  const transformLat = (x: number, y: number) => {
    let value = -100 + 2 * x + 3 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.abs(x));
    value += ((20 * Math.sin(6 * x * Math.PI) + 20 * Math.sin(2 * x * Math.PI)) * 2) / 3;
    value += ((20 * Math.sin(y * Math.PI) + 40 * Math.sin((y / 3) * Math.PI)) * 2) / 3;
    value += ((160 * Math.sin((y / 12) * Math.PI) + 320 * Math.sin((y * Math.PI) / 30)) * 2) / 3;
    return value;
  };
  const transformLng = (x: number, y: number) => {
    let value = 300 + x + 2 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.abs(x));
    value += ((20 * Math.sin(6 * x * Math.PI) + 20 * Math.sin(2 * x * Math.PI)) * 2) / 3;
    value += ((20 * Math.sin(x * Math.PI) + 40 * Math.sin((x / 3) * Math.PI)) * 2) / 3;
    value += ((150 * Math.sin((x / 12) * Math.PI) + 300 * Math.sin((x / 30) * Math.PI)) * 2) / 3;
    return value;
  };
  const a = 6378245;
  const eccentricity = 0.006693421622965943;
  const deltaLat = transformLat(lng - 105, lat - 35);
  const deltaLng = transformLng(lng - 105, lat - 35);
  const radLat = (lat / 180) * Math.PI;
  const magic = 1 - eccentricity * Math.sin(radLat) ** 2;
  const sqrtMagic = Math.sqrt(magic);
  const adjustedLat = (deltaLat * 180) / (((a * (1 - eccentricity)) / (magic * sqrtMagic)) * Math.PI);
  const adjustedLng = (deltaLng * 180) / ((a / sqrtMagic) * Math.cos(radLat) * Math.PI);
  return { x: lng + adjustedLng, y: lat + adjustedLat };
}
