import { useState, type ReactNode } from "react";
import { createPortal } from "react-dom";
import styles from "./HoverTooltip.module.css";

const TOOLTIP_GAP = 6;

type HoverTooltipProps = {
  text: string;
  children: (handlers: {
    onMouseEnter: (event: React.MouseEvent) => void;
    onMouseLeave: () => void;
  }) => ReactNode;
};

export function HoverTooltip({ text, children }: HoverTooltipProps) {
  const [tooltipPos, setTooltipPos] = useState<{ x: number; y: number } | null>(null);

  const handlers = {
    onMouseEnter: (event: React.MouseEvent) => {
      const rect = event.currentTarget.getBoundingClientRect();
      setTooltipPos({
        x: rect.left + rect.width / 2,
        y: rect.bottom + TOOLTIP_GAP,
      });
    },
    onMouseLeave: () => setTooltipPos(null),
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
