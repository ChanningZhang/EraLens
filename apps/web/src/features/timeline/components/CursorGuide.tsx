import { useEffect, useRef, type RefObject } from "react";
import { absFromStageX } from "../model/coordinates";
import {
  clampCursorGuideLabelX,
  cursorGuideStageX,
  formatCursorGuideLabel,
} from "../model/cursorGuide";
import { viewportStore } from "../state/viewportStore";
import styles from "./CursorGuide.module.css";

type Props = {
  stageRef: RefObject<HTMLDivElement | null>;
};

export function CursorGuide({ stageRef }: Props) {
  const overlayRef = useRef<HTMLDivElement>(null);
  const lineRef = useRef<HTMLDivElement>(null);
  const labelRef = useRef<HTMLSpanElement>(null);
  const lastPointerRef = useRef<{ x: number; y: number } | null>(null);

  useEffect(() => {
    const overlay = overlayRef.current;
    const line = lineRef.current;
    const label = labelRef.current;
    if (!overlay || !line || !label) return;

    const hide = () => {
      overlay.dataset.visible = "false";
      lastPointerRef.current = null;
    };

    const paint = (clientX: number, clientY: number | null, pointerType?: string) => {
      if (pointerType === "touch") {
        hide();
        return;
      }

      const stage = stageRef.current;
      if (!stage) {
        hide();
        return;
      }

      const rect = stage.getBoundingClientRect();
      if (clientY !== null && clientY < rect.top) {
        hide();
        return;
      }

      const viewport = viewportStore.getSnapshot();
      const x = cursorGuideStageX(clientX, rect.left, rect.width, viewport.gutterPx);
      if (x === null) {
        hide();
        return;
      }

      lastPointerRef.current = { x: clientX, y: clientY ?? rect.top };
      overlay.style.width = `${rect.width}px`;
      overlay.dataset.visible = "true";
      line.style.transform = `translate3d(${x}px, 0, 0)`;

      const abs = absFromStageX(viewport, x);
      label.textContent = formatCursorGuideLabel(abs, viewport.pxPerMonth);
      const labelX = clampCursorGuideLabelX(
        x,
        rect.width,
        label.offsetWidth,
        4,
        viewport.gutterPx,
      );
      label.style.transform = `translate3d(${labelX}px, 0, 0) translateX(-50%)`;
    };

    const onPointerMove = (event: PointerEvent) => {
      paint(event.clientX, event.clientY, event.pointerType);
    };

    const onViewportChange = () => {
      const last = lastPointerRef.current;
      if (!last) return;
      paint(last.x, last.y);
    };

    window.addEventListener("pointermove", onPointerMove, { passive: true });
    document.documentElement.addEventListener("mouseleave", hide);
    window.addEventListener("blur", hide);
    const unsubscribe = viewportStore.subscribe(onViewportChange);

    return () => {
      window.removeEventListener("pointermove", onPointerMove);
      document.documentElement.removeEventListener("mouseleave", hide);
      window.removeEventListener("blur", hide);
      unsubscribe();
    };
  }, [stageRef]);

  return (
    <div
      ref={overlayRef}
      className={styles.overlay}
      data-visible="false"
      data-timeline-cursor-guide
      aria-hidden="true"
    >
      <div ref={lineRef} className={styles.line} />
      <span ref={labelRef} className={styles.label} />
    </div>
  );
}
