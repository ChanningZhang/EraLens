import styles from "./CapitalCard.module.css";

type CapitalCardProps = {
  historicalName: string;
  modernName: string;
  subtitle: string;
  onClick: () => void;
};

export function CapitalCard({ historicalName, modernName, subtitle, onClick }: CapitalCardProps) {
  return (
    <button type="button" className={styles.card} onClick={onClick}>
      <span className={styles.titleLine}>
        <span className={styles.historicalName}>{historicalName}</span>
        <span className={styles.modernName}>{modernName}</span>
      </span>
      <span className={styles.subtitle}>{subtitle}</span>
    </button>
  );
}
