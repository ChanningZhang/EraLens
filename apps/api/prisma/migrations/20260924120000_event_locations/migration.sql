CREATE TABLE "event_locations" (
    "id" TEXT NOT NULL,
    "historical_name" TEXT NOT NULL,
    "modern_name" TEXT NOT NULL,
    "longitude" DECIMAL(10,7) NOT NULL,
    "latitude" DECIMAL(10,7) NOT NULL,
    "coordinate_system" TEXT NOT NULL DEFAULT 'WGS84',
    "precision" TEXT NOT NULL DEFAULT 'approximate',
    "note" TEXT,
    "links" JSONB NOT NULL DEFAULT '[]',
    CONSTRAINT "event_locations_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "event_locations_longitude_check" CHECK ("longitude" >= -180 AND "longitude" <= 180),
    CONSTRAINT "event_locations_latitude_check" CHECK ("latitude" >= -90 AND "latitude" <= 90)
);

ALTER TABLE "events" ADD COLUMN "location_id" TEXT;
ALTER TABLE "events" ADD CONSTRAINT "events_location_id_fkey"
FOREIGN KEY ("location_id") REFERENCES "event_locations"("id") ON DELETE SET NULL ON UPDATE CASCADE;
CREATE INDEX "events_location_id_idx" ON "events"("location_id");
