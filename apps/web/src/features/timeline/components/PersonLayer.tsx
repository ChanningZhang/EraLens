import type { PlacedPerson } from "../model/personLayout";
import { PersonCard } from "./PersonCard";
import styles from "./PersonLayer.module.css";

type Props = {
  placed: PlacedPerson[];
  top: number;
  height: number;
};

export function PersonLayer({ placed, top, height }: Props) {
  return (
    <div
      className={styles.layer}
      style={{ top, height }}
      aria-hidden={placed.length === 0}
    >
      {placed.map((item) => (
        <PersonCard key={item.person.id} placed={item} />
      ))}
    </div>
  );
}
