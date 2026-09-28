import type { PlacedPerson } from "../model/personLayout";
import { useState } from "react";
import { useSelection } from "../hooks/useSelection";
import { PersonCard } from "./PersonCard";
import styles from "./PersonLayer.module.css";

type Props = {
  placed: PlacedPerson[];
  top: number;
  height: number;
};

export function PersonLayer({ placed, top, height }: Props) {
  const [activePersonId, setActivePersonId] = useState<string | null>(null);
  const selection = useSelection();

  return (
    <div
      className={styles.layer}
      style={{ top, height }}
      aria-hidden={placed.length === 0}
    >
      {placed.map((item) => {
        const selected =
          selection.selected?.type === "person" &&
          selection.selected.id === item.person.id &&
          selection.focusReignId == null;

        return (
          <PersonCard
            key={item.person.id}
            placed={item}
            lineVisible={selected || item.person.id === activePersonId}
            onSelectLine={() => setActivePersonId((current) => current === item.person.id ? null : item.person.id)}
          />
        );
      })}
    </div>
  );
}
