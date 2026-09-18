import { type DynastyGroup } from "@eralens/shared";
import styles from "./DynastyClusterFrame.module.css";

type Props = {
  group: DynastyGroup;
  top: number;
  height: number;
  left: number;
  width: number;
};

export function DynastyClusterFrame({ group, top, height, left, width }: Props) {
  return (
    <div
      className={styles.frame}
      aria-hidden="true"
      style={{ top, height, left, width }}
    >
      <span className={styles.legend}>{group.name}</span>
    </div>
  );
}
