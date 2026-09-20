/** GCJ-02 display envelope for contemporary China (mainland + Hainan + Taiwan). */
export const CHINA_MAP_BOUNDS = {
  minLng: 73,
  maxLng: 136,
  minLat: 17,
  maxLat: 54,
} as const;

/** Keep in sync with ChinaMapBackground.module.css `.outlineWrap` insets. */
export const CHINA_MAP_INSETS = {
  top: 20,
  right: 24,
  bottom: 28,
  gutterExtra: 12,
} as const;

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
  const geoAspect = (maxLng - minLng) / (maxLat - minLat);
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

  return {
    left: insets.left + (maxInnerW - innerW) / 2,
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
  const x = layout.left + ((lng - minLng) / (maxLng - minLng)) * layout.width;
  const y = layout.top + ((maxLat - lat) / (maxLat - minLat)) * layout.height;
  return { x, y };
}

