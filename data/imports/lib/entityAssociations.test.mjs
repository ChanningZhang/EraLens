import { describe, it } from 'node:test';
import assert from 'node:assert/strict';
import { DatabaseSync } from 'node:sqlite';
import { readFileSync, mkdtempSync, mkdirSync, writeFileSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { normalizeAssociation, assertEntityAssociation, relatedEntityRefs, eventAssociationIds } from '../../../packages/shared/src/entityAssociations.mjs';
import { auditPackageOwnership } from './auditPackageOwnership.mjs';
import { serializeSqlitePackages } from './sqlitePackageRows.mjs';

describe('ordinary association invariants', () => {
  it('normalizes reversed pairs and compares Unicode using UTF-8 rather than UTF-16', () => {
    assert.deepEqual(normalizeAssociation('person:p', 'event:e'), {aRef:'event:e',bRef:'person:p'});
    assert.deepEqual(normalizeAssociation('person:\u{10000}', 'person:\uE000'), {aRef:'person:\uE000',bRef:'person:\u{10000}'});
    assert.throws(()=>assertEntityAssociation({aRef:'person:p',bRef:'event:e'}), /UTF-8/);
    assert.throws(()=>normalizeAssociation('person:p','person:p'), /Self/);
    assert.throws(()=>normalizeAssociation('reign:r','person:p'), /endpoint/);
    assert.throws(()=>assertEntityAssociation({aRef:'event:e',bRef:'person:p',kind:'battle'}), /only/);
  });
  it('queries both ends and projects event fields without duplicates', () => {
    const rows=[normalizeAssociation('person:p','event:e'),normalizeAssociation('dynasty:d','event:e'),normalizeAssociation('event:e','event:f')];
    assert.deepEqual(relatedEntityRefs(rows,'person:p'),['event:e']);
    assert.deepEqual(eventAssociationIds('e',[...rows,rows[0]]),{dynastyIds:['d'],participantIds:['p']});
  });
});

describe('SQLite association constraints',()=>{
  it('enforces endpoints, uniqueness, rename restrictions and cascaded deletion',()=>{
    const db=new DatabaseSync(':memory:');
    try {
      db.exec(readFileSync(new URL('../../../data/mobile/schema.sql',import.meta.url),'utf8'));
      db.exec("INSERT INTO persons(id,name) VALUES('p','P'); INSERT INTO events(id,name,kind,time_mode) VALUES('e','E','politics','point');");
      const insert=db.prepare('INSERT INTO entity_associations VALUES(?,?,?,?)');
      insert.run('event','e','person','p');
      db.exec("INSERT INTO entity_associations VALUES('event','e','person','p') ON CONFLICT DO NOTHING");
      assert.equal(db.prepare('SELECT count(*) n FROM entity_associations').get().n,1);
      assert.throws(()=>insert.run('event','e','person','p'), /UNIQUE/);
      assert.throws(()=>insert.run('person','p','event','e'), /CHECK/);
      assert.throws(()=>insert.run('person','p','person','p'), /CHECK/);
      assert.throws(()=>insert.run('event','e','person','missing'), /Invalid association endpoint/);
      assert.throws(()=>db.exec("UPDATE persons SET id='q' WHERE id='p'"), /Cannot rename/);
      assert.throws(()=>db.exec("INSERT INTO relations(id,from_type,from_id,to_type,to_id,kind) VALUES('r','event','e','person','p','succession')"), /CHECK/);
      assert.throws(()=>db.exec("INSERT INTO relations(id,from_type,from_id,to_type,to_id,kind) VALUES('r','person','p','person','p','battle')"), /CHECK/);
      db.exec("DELETE FROM entity_associations WHERE a_type='event' AND a_id='e' AND b_type='person' AND b_id='p'");
      assert.equal(db.prepare('SELECT count(*) n FROM entity_associations').get().n,0);
      insert.run('event','e','person','p');
      db.exec("DELETE FROM events WHERE id='e'");
      assert.equal(db.prepare('SELECT count(*) n FROM entity_associations').get().n,0);
      db.exec("UPDATE persons SET id='q' WHERE id='p'");
      db.exec("INSERT INTO dynasties(id,name,scope,region,start_year,start_month,end_year,end_month,end_confidence,start_abs,end_abs,start_confidence,color_token) VALUES('d','D','cn','east_asia',1,1,2,12,'year',12,35,'year','moss')");
      insert.run('dynasty','d','person','q');
      db.exec("DELETE FROM persons WHERE id='q'");
      assert.equal(db.prepare('SELECT count(*) n FROM entity_associations').get().n,0);
      db.exec("INSERT INTO events(id,name,kind,time_mode) VALUES('f','F','politics','point')");
      insert.run('dynasty','d','event','f');
      db.exec("DELETE FROM dynasties WHERE id='d'");
      assert.equal(db.prepare('SELECT count(*) n FROM entity_associations').get().n,0);
      assert.equal(db.prepare('PRAGMA integrity_check').get().integrity_check,'ok');
    } finally {db.close();}
  });
});

describe('association import ownership',()=>{
  function fixture(change,expectation) {
    const root=mkdtempSync(path.join(tmpdir(),'eralens-association-audit-'));
    const packages={period:{slug:'period',events:[{id:'e'}],persons:[{id:'p'}]},'entity-associations':{slug:'entity-associations',associations:[{aRef:'event:e',bRef:'person:p'}],manifest:{counts:{associations:1}}}};
    try {
      change(packages);
      for (const [slug,cache] of Object.entries(packages)) {mkdirSync(path.join(root,slug));writeFileSync(path.join(root,slug,'cache.json'),JSON.stringify(cache));}
      expectation(()=>auditPackageOwnership(root), packages);
    } finally {rmSync(root,{recursive:true,force:true});}
  }
  it('accepts the single central owner',()=>fixture(()=>{},run=>assert.doesNotThrow(run)));
  it('rejects legacy fields even if empty',()=>fixture(p=>p.period.events[0].participantIds=[],run=>assert.throws(run,/legacy/)));
  it('rejects ownership elsewhere',()=>fixture(p=>p.period.associations=[],run=>assert.throws(run,/belong/)));
  it('rejects duplicate rows and incorrect manifest counts',()=>{
    fixture(p=>{p['entity-associations'].associations.push(p['entity-associations'].associations[0]);p['entity-associations'].manifest.counts.associations=2;},run=>assert.throws(run,/conflicts/));
    fixture(p=>p['entity-associations'].manifest.counts.associations=2,run=>assert.throws(run,/counts/));
    fixture(p=>delete p['entity-associations'].manifest.counts.associations,run=>assert.throws(run,/counts/));
  });
  it('rejects dangling endpoints and retired cleanup SQL',()=>{
    fixture(p=>p['entity-associations'].associations[0].bRef='person:missing',run=>assert.throws(run,/dangling/));
    fixture(p=>p['entity-associations'].preSql="DELETE FROM entity_associations WHERE a_type='event';",(run,packages)=>assert.throws(()=>{run();serializeSqlitePackages(Object.entries(packages).map(([slug,cache])=>({slug,cache})));},/preSql is retired/));
    fixture(p=>p.period.postSql="DELETE FROM persons;",(run,packages)=>assert.throws(()=>{run();serializeSqlitePackages(Object.entries(packages).map(([slug,cache])=>({slug,cache})));},/postSql is retired/));
  });
});
