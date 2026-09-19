import styles from "./ReignWavyEdge.module.css";

type Props = {
  side: "left" | "right";
};

export function ReignWavyEdge({ side }: Props) {
  return (
    <svg
      className={side === "left" ? styles.waveLeft : styles.waveRight}
      viewBox="0 0 6 48"
      preserveAspectRatio="none"
      aria-hidden
    >
      <path
        d="M3,0 C1,4 5,8 3,12 C1,16 5,20 3,24 C1,28 5,32 3,36 C1,40 5,44 3,48"
        fill="none"
        vectorEffect="non-scaling-stroke"
      />
    </svg>
  );
}
