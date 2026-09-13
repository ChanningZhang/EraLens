-- AlterTable
ALTER TABLE "reigns" ADD COLUMN "claim_track" TEXT;
ALTER TABLE "reigns" ADD COLUMN "claim_label" TEXT;
ALTER TABLE "reigns" ADD COLUMN "claim_role" TEXT;

-- CreateIndex
CREATE INDEX "reigns_claim_track_idx" ON "reigns"("claim_track");
