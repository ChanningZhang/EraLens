import { useRef, useState } from "react";
import {
  DETAIL_WIDTH_LIMITS,
  selectionStore,
} from "@/features/timeline/state/selectionStore";
import styles from "./ResizeHandle.module.css";

export function ResizeHandle() {
  const [active, setActive] = useState(false);
  const startX = useRef(0);
  const startWidth = useRef(0);

  return (
    <div
      className={`${styles.handle} ${active ? styles.handleActive : ""}`}
      onPointerDown={(event) => {
        setActive(true);
        startX.current = event.clientX;
        startWidth.current = selectionStore.getSnapshot().detailWidth;
        event.currentTarget.setPointerCapture(event.pointerId);
      }}
      onPointerMove={(event) => {
        if (!active) return;
        const delta = startX.current - event.clientX;
        selectionStore.setDetailWidth(startWidth.current + delta);
      }}
      onPointerUp={(event) => {
        setActive(false);
        event.currentTarget.releasePointerCapture(event.pointerId);
      }}
      onDoubleClick={() => selectionStore.resetDetailWidth()}
      role="separator"
      aria-orientation="vertical"
      aria-valuemin={DETAIL_WIDTH_LIMITS.min}
      aria-valuemax={DETAIL_WIDTH_LIMITS.max}
      aria-valuenow={selectionStore.getSnapshot().detailWidth}
    />
  );
}
