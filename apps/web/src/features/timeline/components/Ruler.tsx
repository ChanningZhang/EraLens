import { useEffect, useMemo, useRef, useState } from "react";
import { useViewport } from "../hooks/useViewport";
import { projectAbs } from "../model/coordinates";
import { buildRulerTicks, getRulerTickSteps } from "../model/rulerTicks";
import { viewportStore } from "../state/viewportStore";
import styles from "./Ruler.module.css";

export function Ruler() {
  const viewport = useViewport();
  const trackRef = useRef<HTMLDivElement>(null);
  const [dragging, setDragging] = useState(false);
  const draggingRef = useRef(false);
  const inertiaRef = useRef<number | null>(null);
  const panFrameRef = useRef<number | null>(null);
  const pendingPanPxRef = useRef(0);
  const velocityRef = useRef(0);
  const lastMoveRef = useRef<{ x: number; t: number } | null>(null);

  const tickSteps = getRulerTickSteps(viewport.pxPerMonth);

  const ticks = useMemo(
    () => buildRulerTicks(viewport.startAbs, viewport.endAbs, viewport.pxPerMonth),
    [viewport.startAbs, viewport.endAbs, viewport.pxPerMonth],
  );

  const zoomHint = useMemo(() => {
    if (tickSteps.labelYears === 1) return "每年";
    if (tickSteps.labelYears === 5) return "每 5 年";
    if (tickSteps.labelYears === 10) return "每 10 年";
    return `每 ${tickSteps.labelYears} 年`;
  }, [tickSteps.labelYears]);

  const flushPendingPan = () => {
    if (panFrameRef.current !== null) {
      cancelAnimationFrame(panFrameRef.current);
      panFrameRef.current = null;
    }
    const deltaPx = pendingPanPxRef.current;
    pendingPanPxRef.current = 0;
    if (deltaPx !== 0) viewportStore.panByPixels(deltaPx);
  };

  const queuePan = (deltaPx: number) => {
    pendingPanPxRef.current += deltaPx;
    if (panFrameRef.current !== null) return;
    panFrameRef.current = requestAnimationFrame(() => {
      panFrameRef.current = null;
      const pending = pendingPanPxRef.current;
      pendingPanPxRef.current = 0;
      if (pending !== 0) viewportStore.panByPixels(pending);
    });
  };

  useEffect(() => {
    return () => {
      if (inertiaRef.current !== null) cancelAnimationFrame(inertiaRef.current);
      if (panFrameRef.current !== null) cancelAnimationFrame(panFrameRef.current);
    };
  }, []);

  const onPointerDown = (event: React.PointerEvent) => {
    if (inertiaRef.current) {
      cancelAnimationFrame(inertiaRef.current);
      inertiaRef.current = null;
    }
    setDragging(true);
    draggingRef.current = true;
    lastMoveRef.current = { x: event.clientX, t: performance.now() };
    velocityRef.current = 0;
    event.currentTarget.setPointerCapture(event.pointerId);
  };

  const onPointerMove = (event: React.PointerEvent) => {
    if (!draggingRef.current) return;
    const last = lastMoveRef.current;
    if (!last) return;

    const deltaPx = event.clientX - last.x;
    queuePan(deltaPx);

    const now = performance.now();
    const dt = now - last.t;
    if (dt > 0) {
      velocityRef.current = deltaPx / dt;
    }
    lastMoveRef.current = { x: event.clientX, t: now };
  };

  const onPointerUp = (event: React.PointerEvent) => {
    if (!draggingRef.current) return;
    setDragging(false);
    draggingRef.current = false;
    flushPendingPan();

    let velocity = velocityRef.current;
    const animate = () => {
      if (Math.abs(velocity) < 0.01) {
        inertiaRef.current = null;
        return;
      }
      viewportStore.panByPixels(velocity * 16);
      velocity *= 0.92;
      inertiaRef.current = requestAnimationFrame(animate);
    };
    if (Math.abs(velocity) > 0.05) {
      inertiaRef.current = requestAnimationFrame(animate);
    }

    lastMoveRef.current = null;
    if (event.currentTarget.hasPointerCapture(event.pointerId)) {
      event.currentTarget.releasePointerCapture(event.pointerId);
    }
  };

  return (
    <div className={styles.ruler} data-timeline-pan>
      <div className={styles.ringShell}>
        <div
          ref={trackRef}
          className={`${styles.ringTrack} ${dragging ? styles.ringTrackDragging : ""}`}
          onPointerDown={onPointerDown}
          onPointerMove={onPointerMove}
          onPointerUp={onPointerUp}
          onPointerCancel={onPointerUp}
          role="slider"
          aria-label="时间环形标尺"
          aria-valuetext={`年份标签${zoomHint}`}
        >
          <div className={styles.scaleViewport}>
            <div className={styles.tickBand}>
              {ticks.map((tick) => {
                const left = projectAbs(viewport, tick.abs);
                if (tick.kind === "label") {
                  return (
                    <div
                      key={`label-${tick.abs}`}
                      className={`${styles.tick} ${styles.tickLabel}`}
                      style={{ left }}
                    >
                      <span className={styles.tickText}>{tick.text}</span>
                    </div>
                  );
                }

                return (
                  <div
                    key={`${tick.kind}-${tick.abs}`}
                    className={`${styles.tick} ${
                      tick.kind === "mid" ? styles.tickMid : styles.tickMinor
                    }`}
                    style={{ left }}
                  />
                );
              })}
            </div>
          </div>
          <span className={styles.zoomHint}>{zoomHint} · 双指捏合缩放</span>
        </div>
      </div>
    </div>
  );
}
