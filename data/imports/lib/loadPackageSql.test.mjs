import { test } from 'node:test';
import assert from 'node:assert/strict';
import { DatabaseSync } from 'node:sqlite';
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { packageStatements, readPackageSql, loadPackageSql, refreshContent } from './loadPackageSql.mjs';
import { discoverPackages } from './discoverPackages.mjs';
import { serializeSqlitePackages } from './sqlitePackageRows.mjs';
import path from 'node:path';

const root = fileURLToPath(new URL('../', import.meta.url));
const schema = readFileSync(new URL('../../mobile/schema.sql', import.meta.url), 'utf8');
const createDb = () => {
  const db = new DatabaseSync(':memory:');
  db.exec('PRAGMA foreign_keys=ON;');
  db.exec(schema);
  return db;
};

test('package SQL preserves semicolons, escaped quotes, newlines and transaction words in text', () => {
  const sql = `-- SQLite import package: fixture\nBEGIN;\nINSERT INTO "persons" ("id","name") VALUES ('p','It''s;\nCOMMIT; -- text');\nCOMMIT;\n`;
  const db = createDb();
  try {
    loadPackageSql(db, [{ statements: packageStatements(sql).map(row => row.sql) }]);
    assert.equal(db.prepare('SELECT name FROM persons').get().name, "It's;\nCOMMIT; -- text");
    assert.throws(() => packageStatements(sql.replace(/\nCOMMIT;\n$/, '')), /wrapper/);
    assert.throws(() => packageStatements('-- SQLite import package: bad\nBEGIN;\nDELETE FROM persons;\nCOMMIT;\n'), /INSERT/);
  } finally { db.close(); }
});

test('all real package SQL loads across package dependencies with the same rows as cache serialization', () => {
  const actual = createDb();
  const expected = createDb();
  try {
    const batches = readPackageSql(root);
    refreshContent(actual, () => loadPackageSql(actual, batches));
    const serialized = serializeSqlitePackages(discoverPackages(root).map(slug => ({
      slug, cache: JSON.parse(readFileSync(path.join(root, slug, 'cache.json'), 'utf8')),
    })));
    expected.exec(serialized.sql);
    for (const { table } of batches) {
      const ordering = table === 'entity_associations' ? 'a_type,a_id,b_type,b_id' : 'id';
      const query = `SELECT * FROM "${table}" ORDER BY ${ordering}`;
      assert.deepEqual(actual.prepare(query).all(), expected.prepare(query).all(), table);
    }
    // A failed refresh must restore both content and metadata, even after inserts succeeded.
    actual.exec(`INSERT INTO content_metadata VALUES ('sentinel','"previous"');`);
    const previous = actual.prepare('SELECT * FROM persons ORDER BY id').all();
    assert.throws(() => refreshContent(actual, () => {
      loadPackageSql(actual, batches);
      actual.exec(`INSERT INTO reigns(id,dynasty_id,person_id,title,start_abs) VALUES('broken','missing','missing','',0);`);
    }));
    assert.deepEqual(actual.prepare('SELECT * FROM persons ORDER BY id').all(), previous);
    assert.equal(actual.prepare('SELECT value FROM content_metadata WHERE key=\'sentinel\'').get().value, '"previous"');
    actual.exec(`INSERT INTO persons(id,name) VALUES ('retired','old');`);
    refreshContent(actual, () => loadPackageSql(actual, batches));
    assert.equal(actual.prepare(`SELECT id FROM persons WHERE id='retired'`).get(), undefined);
    assert.deepEqual(actual.prepare('PRAGMA foreign_key_check').all(), []);
  } finally { actual.close(); expected.close(); }
});
