import { TIMELINE_GUTTER_PX, TIMELINE_RAIL_INSET_PX, TIMELINE_RAIL_LABEL_WIDTH_PX } from "./dynastyLaneGroups";

export type TimelineLayoutPreferences = {
  railCollapsed: boolean;
  density: "auto" | "comfortable" | "compact";
};

export const DEFAULT_TIMELINE_LAYOUT_PREFERENCES: TimelineLayoutPreferences = {
  railCollapsed: false,
  density: "auto",
};

/** Presentation depends on available container width, including iPad Split View. */
export function resolveTimelinePresentation(widthPx: number, preferences = DEFAULT_TIMELINE_LAYOUT_PREFERENCES) {
  const narrow = widthPx <= 600;
  const compact = preferences.density === "compact" || (preferences.density === "auto" && narrow);
  const railCollapsed = narrow && preferences.railCollapsed;
  const expandedGutter = narrow ? Math.round(Math.min(88, Math.max(72, widthPx * 0.2))) : TIMELINE_GUTTER_PX;
  const railInset = narrow ? 6 : TIMELINE_RAIL_INSET_PX;
  return {
    narrow,
    compact,
    railCollapsed,
    gutterPx: railCollapsed ? 12 : expandedGutter,
    railInsetPx: railInset,
    railLabelWidthPx: narrow ? expandedGutter - railInset - 8 : TIMELINE_RAIL_LABEL_WIDTH_PX,
    rowHeightPx: compact ? 36 : 40,
    lanePaddingPx: compact ? 4 : 6,
    railChipHeightPx: 36,
    railChipTopPx: compact ? 4 : 8,
  };
}

export type TimelinePresentation = ReturnType<typeof resolveTimelinePresentation>;
