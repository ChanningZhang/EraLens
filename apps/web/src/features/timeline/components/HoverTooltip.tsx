import { useState, type ReactNode } from "react";
import { createPortal } from "react-dom";
import styles from "./HoverTooltip.module.css";

const TOOLTIP_GAP = 6;

type HoverHandlers = {
  onMouseEnter: (event: React.MouseEvent) => void;
  onMouseLeave: () => void;
  onMouseMove?: (event: React.MouseEvent) => void;
};

type HoverTooltipProps = {
  text: string;
  /** Follow the cursor. Use for thin/line targets whose bounding box is huge. */
  followPointer?: boolean;
  children: (handlers: HoverHandlers) => ReactNode;
};

function positionFromEvent(event: React.MouseEvent, followPointer: boolean) {
  if (followPointer) {
    return { x: event.clientX, y: event.clientY + TOOLTIP_GAP };
  }
  const rect = event.currentTarget.getBoundingClientRect();
  return {
    x: rect.left + rect.width / 2,
    y: rect.bottom + TOOLTIP_GAP,
  };
}

export function HoverTooltip({
  text,
  followPointer = false,
  children,
}: HoverTooltipProps) {
  const [tooltipPos, setTooltipPos] = useState<{ x: number; y: number } | null>(null);

  const handlers: HoverHandlers = {
    onMouseEnter: (event: React.MouseEvent) => {
      setTooltipPos(positionFromEvent(event, followPointer));
    },
    onMouseLeave: () => setTooltipPos(null),
    ...(followPointer
      ? {
          onMouseMove: (event: React.MouseEvent) => {
            setTooltipPos(positionFromEvent(event, true));
          },
        }
      : {}),
  };

  return (
    <>
      {children(handlers)}
      {tooltipPos &&
        createPortal(
          <div
            className={styles.tooltip}
            style={{
              left: tooltipPos.x,
              top: tooltipPos.y,
              transform: "translateX(-50%)",
            }}
          >
            {text}
          </div>,
          document.body,
        )}
    </>
  );
}
