import { useEffect, useId, useRef, useState, type FocusEvent, type MouseEvent as ReactMouseEvent, type PointerEvent as ReactPointerEvent, type ReactNode } from "react";
import { createPortal } from "react-dom";
import styles from "./InfoPopover.module.css";

const GAP = 8;
const LONG_PRESS_MS = 480;
const TOUCH_VISIBLE_MS = 2200;

type InfoHandlers = {
  "aria-describedby": string;
  onPointerEnter: (event: ReactPointerEvent<Element>) => void;
  onPointerLeave: (event: ReactPointerEvent<Element>) => void;
  onPointerMove: (event: ReactPointerEvent<Element>) => void;
  onPointerDown: (event: ReactPointerEvent<Element>) => void;
  onPointerUp: (event: ReactPointerEvent<Element>) => void;
  onPointerCancel: () => void;
  onContextMenu: (event: ReactMouseEvent<Element>) => void;
  onFocus: (event: FocusEvent<Element>) => void;
  onBlur: () => void;
};

type Props = {
  text: string;
  /** Follow the pointer for thin targets such as relationship lines. */
  followPointer?: boolean;
  children: (handlers: InfoHandlers) => ReactNode;
};

type Position = { x: number; y: number };

function anchorPosition(element: Element, followPointer: boolean, event?: ReactPointerEvent<Element>): Position {
  if (followPointer && event) return { x: event.clientX, y: event.clientY + GAP };
  const rect = element.getBoundingClientRect();
  return { x: rect.left + rect.width / 2, y: rect.bottom + GAP };
}

export function InfoPopover({ text, followPointer = false, children }: Props) {
  const id = useId();
  const [position, setPosition] = useState<Position | null>(null);
  const [visible, setVisible] = useState(false);
  const longPressTimer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const touchDismissTimer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const longPressShown = useRef(false);
  const touchStart = useRef<Position | null>(null);

  const clearTimers = () => {
    if (longPressTimer.current) clearTimeout(longPressTimer.current);
    if (touchDismissTimer.current) clearTimeout(touchDismissTimer.current);
    longPressTimer.current = null;
    touchDismissTimer.current = null;
  };

  useEffect(() => clearTimers, []);

  const handlers: InfoHandlers = {
    "aria-describedby": id,
    onPointerEnter: (event) => {
      if (event.pointerType !== "touch") {
        setPosition(anchorPosition(event.currentTarget, followPointer, event));
        setVisible(true);
      }
    },
    onPointerLeave: (event) => {
      if (event.pointerType !== "touch") setVisible(false);
    },
    onPointerMove: (event) => {
      if (event.pointerType === "touch" && longPressTimer.current) {
        const origin = touchStart.current;
        if (origin && Math.hypot(event.clientX - origin.x, event.clientY - origin.y) > 10) {
          clearTimers();
        }
      } else if (followPointer && event.pointerType !== "touch" && visible) {
        setPosition(anchorPosition(event.currentTarget, true, event));
      }
    },
    onPointerDown: (event) => {
      if (event.pointerType !== "touch") return;
      clearTimers();
      longPressShown.current = false;
      touchStart.current = { x: event.clientX, y: event.clientY };
      const target = event.currentTarget;
      longPressTimer.current = setTimeout(() => {
        longPressShown.current = true;
        setPosition(anchorPosition(target, false));
        setVisible(true);
      }, LONG_PRESS_MS);
    },
    onPointerUp: (event) => {
      if (event.pointerType !== "touch") return;
      if (longPressTimer.current) clearTimeout(longPressTimer.current);
      longPressTimer.current = null;
      if (!longPressShown.current) return;
      // A long press is an information gesture, not an activation of the card.
      event.preventDefault();
      event.stopPropagation();
      touchDismissTimer.current = setTimeout(() => {
        setVisible(false);
        longPressShown.current = false;
        touchDismissTimer.current = null;
      }, TOUCH_VISIBLE_MS);
    },
    onPointerCancel: () => {
      clearTimers();
      setVisible(false);
      longPressShown.current = false;
    },
    onContextMenu: (event) => {
      if (longPressShown.current) event.preventDefault();
    },
    onFocus: (event) => {
      setPosition(anchorPosition(event.currentTarget, false));
      setVisible(true);
    },
    onBlur: () => setVisible(false),
  };

  const popover = visible && position && (
    <div
      id={id}
      role="tooltip"
      className={styles.popover}
      style={{ left: position.x, top: position.y }}
    >
      {text}
    </div>
  );

  return (
    <>
      {children(handlers)}
      {popover && typeof document !== "undefined" && createPortal(popover, document.body)}
    </>
  );
}
