#!/usr/bin/env node
/** AbsMonth calculator — must match packages/shared/src/time.ts */

function toAstroYear(year) {
  return year > 0 ? year : year + 1;
}

function absMonth(year, month = 1) {
  const astro = toAstroYear(Number(year));
  const m = Number(month);
  if (m < 1 || m > 12) throw new Error(`month must be 1-12, got ${m}`);
  return astro * 12 + (m - 1);
}

const args = process.argv.slice(2);
if (args.length === 0) {
  console.log(`Usage: node compute-abs.mjs <year> [month]
Examples:
  node compute-abs.mjs 220 12   → 2651
  node compute-abs.mjs -221 1   → BCE abs`);
  process.exit(0);
}

const year = Number(args[0]);
const month = args[1] != null ? Number(args[1]) : 1;
if (!Number.isFinite(year)) {
  console.error("Invalid year");
  process.exit(1);
}

const abs = absMonth(year, month);
console.log(abs);
