import { readFileSync } from 'node:fs';
import path from 'node:path';
import { discoverPackages } from './discoverPackages.mjs';

// Generated package SQL contains only INSERTs, plus its standalone transaction wrapper.
// Split outside SQLite string literals: historical text may contain semicolons/newlines.
export function packageStatements(sql) {
  const match = /^-- SQLite import package: [^\n]+\nBEGIN;\n([\s\S]*)\nCOMMIT;\s*$/.exec(sql);
  if (!match) throw new Error('Invalid generated package SQL wrapper');
  const body = match[1];
  const statements = [];
  let quoted = false;
  let start = 0;
  for (let i = 0; i < body.length; i++) {
    if (body[i] === "'") {
      if (quoted && body[i + 1] === "'") i++;
      else quoted = !quoted;
    } else if (body[i] === ';' && !quoted) {
      const statement = body.slice(start, i + 1).trim();
      const table = /^INSERT INTO "([a-z_]+)" \(/.exec(statement)?.[1];
      if (!table) throw new Error('Package SQL must contain generated INSERT statements only');
      statements.push({ table, sql: statement });
      start = i + 1;
    }
  }
  if (quoted || body.slice(start).trim()) throw new Error('Unterminated package SQL statement');
  return statements;
}

export function readPackageSql(importsRoot) {
  const tableOrder = ['dynasty_groups', 'dynasties', 'persons', 'locations', 'reigns', 'events', 'relations', 'entity_associations', 'location_mapping'];
  const byTable = new Map(tableOrder.map(table => [table, []]));
  for (const slug of discoverPackages(importsRoot)) {
    const sql = readFileSync(path.join(importsRoot, slug, 'import.sql'), 'utf8');
    for (const statement of packageStatements(sql)) {
      if (!byTable.has(statement.table)) throw new Error(`${slug}: unsupported table ${statement.table}`);
      byTable.get(statement.table).push(statement.sql);
    }
  }
  // Dependencies cross package boundaries, so all packages' entities precede their references.
  return [...byTable].map(([table, statements]) => ({ table, statements }));
}

export function loadPackageSql(database, batches) {
  for (const { statements } of batches) for (const statement of statements) database.exec(statement);
}

export function refreshContent(database, load) {
  database.exec('BEGIN IMMEDIATE;');
  try {
    for (const table of ['search_entries', 'content_metadata', 'entity_associations', 'relations', 'location_mapping', 'events', 'reigns', 'dynasties', 'dynasty_groups', 'persons', 'locations']) {
      database.exec(`DELETE FROM "${table}";`);
    }
    const result = load();
    database.exec('COMMIT;');
    return result;
  } catch (error) {
    database.exec('ROLLBACK;');
    throw error;
  }
}
