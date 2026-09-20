import chinaOutline from "@/assets/china-outline.svg?raw";
import styles from "./ChinaMapBackground.module.css";

export function ChinaMapBackground() {
  return (
    <div className={styles.background} aria-hidden="true">
      <div className={styles.veil} />
      <div
        className={styles.outlineWrap}
        // Inline SVG so theme tokens and gradients apply (img cannot use currentColor/CSS vars).
        dangerouslySetInnerHTML={{ __html: chinaOutline }}
      />
    </div>
  );
}
