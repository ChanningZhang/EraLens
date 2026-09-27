import type { ButtonHTMLAttributes } from "react";
import styles from "./ExpandToggle.module.css";

type ExpandToggleProps = Omit<ButtonHTMLAttributes<HTMLButtonElement>, "children" | "aria-label" | "aria-expanded" | "title"> & {
  expanded: boolean;
  expandLabel: string;
  collapseLabel: string;
  axis?: "vertical" | "horizontal";
};

export function ExpandToggle({ expanded, expandLabel, collapseLabel, axis = "vertical", className, onPointerDown, ...props }: ExpandToggleProps) {
  const label = expanded ? collapseLabel : expandLabel;
  const horizontal = axis === "horizontal";
  const arrow = horizontal
    ? expanded ? "m6 1-5 5 5 5" : "m1 1 5 5-5 5"
    : expanded ? "M1 6 6 1l5 5" : "m1 1 5 5 5-5";
  return (
    <button
      {...props}
      type="button"
      className={`${styles.toggle} ${className ?? ""}`}
      data-axis={axis}
      aria-label={label}
      title={label}
      aria-expanded={expanded}
      onPointerDown={(event) => {
        event.stopPropagation();
        onPointerDown?.(event);
      }}
    >
      <svg aria-hidden="true" viewBox={horizontal ? "0 0 7 12" : "0 0 12 7"} focusable="false">
        <path d={arrow} />
      </svg>
    </button>
  );
}
