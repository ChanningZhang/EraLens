-- Merge display overrides into title, then drop redundant column.
UPDATE reigns
SET title = preferred_appellation->>'name'
WHERE preferred_appellation IS NOT NULL
  AND preferred_appellation->>'name' IS NOT NULL
  AND preferred_appellation->>'name' <> title;

ALTER TABLE reigns DROP COLUMN preferred_appellation;
