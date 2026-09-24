import type { PlacedPerson } from "../model/personLayout";
import { motion, useReducedMotion } from "framer-motion";
import { PersonCard } from "./PersonCard";
import styles from "./PersonLayer.module.css";

type Props = {
  placed: PlacedPerson[];
  top: number;
  height: number;
};

export function PersonLayer({ placed, top, height }: Props) {
  const reduceMotion = useReducedMotion();
  return (
    <motion.div
      className={styles.layer}
      animate={{ top, height }}
      transition={{ duration: reduceMotion ? 0 : 0.24, ease: [0.2, 0.8, 0.2, 1] }}
      aria-hidden={placed.length === 0}
    >
      {placed.map((item) => (
        <PersonCard key={item.person.id} placed={item} />
      ))}
    </motion.div>
  );
}
