import { type DynastyGroup } from "@eralens/shared";
import { motion, useReducedMotion } from "framer-motion";
import styles from "./DynastyClusterFrame.module.css";

type Props = {
  group: DynastyGroup;
  top: number;
  height: number;
  left: number;
  width: number;
};

export function DynastyClusterFrame({ group, top, height, left, width }: Props) {
  const reduceMotion = useReducedMotion();
  return (
    <motion.div
      className={styles.frame}
      aria-hidden="true"
      initial={reduceMotion ? false : { top: top + 10, height, opacity: 0 }}
      animate={{ top, height, opacity: 1 }}
      exit={{ opacity: 0, transition: { duration: reduceMotion ? 0 : 0.14 } }}
      transition={{ duration: reduceMotion ? 0 : 0.24, ease: [0.2, 0.8, 0.2, 1] }}
      style={{ left, width }}
    >
      <span className={styles.legend}>{group.name}</span>
    </motion.div>
  );
}
