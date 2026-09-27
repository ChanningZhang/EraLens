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
  const rowHeightPx = compact ? 32 : 36;
  const lanePaddingPx = 4;
  return {
    narrow,
    compact,
    railCollapsed,
    gutterPx: railCollapsed ? 12 : TIMELINE_GUTTER_PX,
    railInsetPx: TIMELINE_RAIL_INSET_PX,
    railLabelWidthPx: TIMELINE_RAIL_LABEL_WIDTH_PX,
    rowHeightPx,
    lanePaddingPx,
    railChipHeightPx: rowHeightPx,
    railChipTopPx: lanePaddingPx,
  };
}

export type TimelinePresentation = ReturnType<typeof resolveTimelinePresentation>;
