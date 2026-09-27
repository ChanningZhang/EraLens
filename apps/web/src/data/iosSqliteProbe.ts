import { CapacitorSQLite, SQLiteConnection } from "@capacitor-community/sqlite";

const databaseName = "eralens-probe";
const sqlite = new SQLiteConnection(CapacitorSQLite);

/** Runs only in the native shell to verify a bundled SQLite file and bound parameters. */
export async function runIosSqliteProbe(): Promise<void> {
  await sqlite.copyFromAssets();
  const database = await sqlite.createConnection(databaseName, false, "no-encryption", 1, false);
  try {
    await database.open();
    const result = await database.query(
      "SELECT label, historical_year FROM ios_probe WHERE id = ?",
      ["qin-unification"],
    );
    const row = result.values?.[0] as { label?: string; historical_year?: number } | undefined;
    const colorMixProbe = document.createElement("span");
    colorMixProbe.style.color = "color-mix(in srgb, rgb(255 0 0) 50%, rgb(0 0 255))";
    document.body.append(colorMixProbe);
    const colorMixComputed = getComputedStyle(colorMixProbe).color;
    colorMixProbe.remove();
    const colorMixSupported = CSS.supports("color", "color-mix(in srgb, red 50%, blue)")
      && colorMixComputed !== ""
      && colorMixComputed !== "rgb(0, 0, 0)";

    if (row?.label !== "秦始皇统一六国" || row.historical_year !== -221 || !colorMixSupported) {
      throw new Error("The SQLite row or WebKit color-mix probe returned an unexpected result.");
    }

    await database.run(
      `INSERT OR REPLACE INTO ios_probe_result
       (id, label, historical_year, color_mix_supported, color_mix_computed)
       VALUES (1, ?, ?, 1, ?)`,
      [row.label, row.historical_year, colorMixComputed],
    );

    console.info("[EraLens] bundled SQLite and color-mix probes passed", { ...row, colorMixComputed });
  } finally {
    await database.close();
    await sqlite.closeConnection(databaseName, false);
  }
}
