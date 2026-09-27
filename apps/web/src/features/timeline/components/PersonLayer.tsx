import type { PlacedPerson } from "../model/personLayout";
import { useState } from "react";
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
  const [activePersonId, setActivePersonId] = useState<string | null>(null);

  return (
    <motion.div
      className={styles.layer}
      animate={{ top, height }}
      transition={{ duration: reduceMotion ? 0 : 0.24, ease: [0.2, 0.8, 0.2, 1] }}
      aria-hidden={placed.length === 0}
    >
      {placed.map((item) => (
        <PersonCard
          key={item.person.id}
          placed={item}
          lineVisible={item.person.id === activePersonId}
          onSelectLine={() => setActivePersonId((current) => current === item.person.id ? null : item.person.id)}
        />
      ))}
    </motion.div>
  );
}
