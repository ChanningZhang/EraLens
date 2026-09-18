-- CreateTable
CREATE TABLE "dynasty_groups" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "alt_names" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "scope" TEXT NOT NULL DEFAULT 'cn',
    "start_year" INTEGER NOT NULL,
    "start_month" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,
    "end_month" INTEGER NOT NULL,
    "start_abs" INTEGER NOT NULL,
    "end_abs" INTEGER NOT NULL,
    "precision" TEXT NOT NULL DEFAULT 'year',
    "note" TEXT,
    "span" int4range GENERATED ALWAYS AS (int4range("start_abs", "end_abs", '[]')) STORED,

    CONSTRAINT "dynasty_groups_pkey" PRIMARY KEY ("id")
);

-- AlterTable
ALTER TABLE "dynasties" ADD COLUMN "group_id" TEXT;

-- AddForeignKey
ALTER TABLE "dynasties" ADD CONSTRAINT "dynasties_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "dynasty_groups"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- CreateIndex
CREATE INDEX "dynasty_groups_scope_start_abs_end_abs_idx" ON "dynasty_groups"("scope", "start_abs", "end_abs");

-- CreateIndex
CREATE INDEX "dynasties_group_id_idx" ON "dynasties"("group_id");
