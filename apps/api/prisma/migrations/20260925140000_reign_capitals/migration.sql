CREATE TABLE "reign_capitals" (
    "reign_id" TEXT NOT NULL,
    "capital_id" TEXT NOT NULL,

    CONSTRAINT "reign_capitals_pkey" PRIMARY KEY ("reign_id", "capital_id")
);

CREATE INDEX "reign_capitals_capital_id_idx" ON "reign_capitals"("capital_id");

ALTER TABLE "reign_capitals"
ADD CONSTRAINT "reign_capitals_reign_id_fkey"
FOREIGN KEY ("reign_id") REFERENCES "reigns"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "reign_capitals"
ADD CONSTRAINT "reign_capitals_capital_id_fkey"
FOREIGN KEY ("capital_id") REFERENCES "dynasty_capitals"("id") ON DELETE CASCADE ON UPDATE CASCADE;
