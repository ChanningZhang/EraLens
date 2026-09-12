import type { PlacedPerson } from "../model/personLayout";
import { PersonCard } from "./PersonCard";
import styles from "./PersonLayer.module.css";

type Props = {
  placed: PlacedPerson[];
  top: number;
};

export function PersonLayer({ placed, top }: Props) {
  return (
    <div className={styles.layer} style={{ top }} aria-hidden={placed.length === 0}>
      {placed.map((item) => (
        <PersonCard key={item.person.id} placed={item} />
      ))}
    </div>
  );
}
