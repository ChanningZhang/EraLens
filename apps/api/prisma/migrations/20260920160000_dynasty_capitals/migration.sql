-- CreateTable
CREATE TABLE "dynasty_capitals" (
    "id" TEXT NOT NULL,
    "dynasty_id" TEXT NOT NULL,
    "historical_name" TEXT NOT NULL,
    "modern_name" TEXT NOT NULL,
    "longitude" DECIMAL(10,7) NOT NULL,
    "latitude" DECIMAL(10,7) NOT NULL,
    "coordinate_system" TEXT NOT NULL DEFAULT 'GCJ02',
    "start_year" INTEGER NOT NULL,
    "start_month" INTEGER NOT NULL,
    "start_day" INTEGER,
    "end_year" INTEGER NOT NULL,
    "end_month" INTEGER NOT NULL,
    "end_day" INTEGER,
    "start_abs" INTEGER NOT NULL,
    "end_abs" INTEGER NOT NULL,
    "precision" TEXT NOT NULL DEFAULT 'year',
    "start_date_confidence" TEXT,
    "end_date_confidence" TEXT,
    "role" TEXT NOT NULL DEFAULT 'primary',
    "claim_track" TEXT,
    "note" TEXT,
    "links" JSONB NOT NULL DEFAULT '[]',

    CONSTRAINT "dynasty_capitals_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "dynasty_capitals_dynasty_id_idx" ON "dynasty_capitals"("dynasty_id");

-- CreateIndex
CREATE INDEX "dynasty_capitals_start_abs_end_abs_idx" ON "dynasty_capitals"("start_abs", "end_abs");

-- AddForeignKey
ALTER TABLE "dynasty_capitals" ADD CONSTRAINT "dynasty_capitals_dynasty_id_fkey" FOREIGN KEY ("dynasty_id") REFERENCES "dynasties"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
