import { useSelection } from "../hooks/useSelection";
import { useViewport } from "../hooks/useViewport";
import { personDetailLevel } from "../model/lod";
import type { PlacedPerson } from "../model/personLayout";
import { selectionStore } from "../state/selectionStore";
import styles from "./PersonCard.module.css";

type Props = {
  placed: PlacedPerson;
};

export function PersonCard({ placed }: Props) {
  const viewport = useViewport();
  const selection = useSelection();
  const { person, left, width, top, startAbs } = placed;
  const detail = personDetailLevel(viewport.lod, width);
  const selected =
    selection.selected?.type === "person" && selection.selected.id === person.id;
  const role = person.roles[0];

  return (
    <button
      type="button"
      className={[
        styles.card,
        detail === "dot" ? styles.dot : "",
        detail === "compact" ? styles.compact : "",
        selected ? styles.selected : "",
      ]
        .filter(Boolean)
        .join(" ")}
      style={{ left, width, top }}
      onClick={() => {
        selectionStore.select({ type: "person", id: person.id }, startAbs);
        selectionStore.syncToUrl(viewport.centerAbs);
      }}
      aria-label={role ? `${person.name}，${role}` : person.name}
      title={person.name}
    >
      {detail !== "dot" && <span className={styles.name}>{person.name}</span>}
      {detail === "full" && role && <span className={styles.role}>{role}</span>}
    </button>
  );
}
