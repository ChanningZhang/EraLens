-- CreateTable
CREATE TABLE "persons" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "birth_year" INTEGER,
    "birth_month" INTEGER,
    "death_year" INTEGER,
    "death_month" INTEGER,
    "roles" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "bio" TEXT,
    "links" JSONB NOT NULL DEFAULT '[]',

    CONSTRAINT "persons_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "dynasties" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "alt_names" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "scope" TEXT NOT NULL DEFAULT 'cn',
    "region" TEXT NOT NULL DEFAULT 'east_asia',
    "start_year" INTEGER NOT NULL,
    "start_month" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,
    "end_month" INTEGER NOT NULL,
    "start_abs" INTEGER NOT NULL,
    "end_abs" INTEGER NOT NULL,
    "precision" TEXT NOT NULL DEFAULT 'year',
    "color_token" TEXT NOT NULL,
    "parent_id" TEXT,
    "note" TEXT,
    "span" int4range GENERATED ALWAYS AS (int4range("start_abs", "end_abs", '[]')) STORED,

    CONSTRAINT "dynasties_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "reigns" (
    "id" TEXT NOT NULL,
    "dynasty_id" TEXT NOT NULL,
    "person_id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "posthumous_name" TEXT,
    "temple_name" TEXT,
    "preferred_appellation" JSONB,
    "start_year" INTEGER NOT NULL,
    "start_month" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,
    "end_month" INTEGER NOT NULL,
    "start_abs" INTEGER NOT NULL,
    "end_abs" INTEGER NOT NULL,
    "precision" TEXT NOT NULL DEFAULT 'year',
    "span" int4range GENERATED ALWAYS AS (int4range("start_abs", "end_abs", '[]')) STORED,

    CONSTRAINT "reigns_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "era_names" (
    "id" SERIAL NOT NULL,
    "reign_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "start_year" INTEGER NOT NULL,
    "start_month" INTEGER NOT NULL,
    "end_year" INTEGER NOT NULL,
    "end_month" INTEGER NOT NULL,
    "start_abs" INTEGER NOT NULL,
    "end_abs" INTEGER NOT NULL,
    "sort_order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "era_names_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "events" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "kind" TEXT NOT NULL DEFAULT 'other',
    "at_year" INTEGER,
    "at_month" INTEGER,
    "at_abs" INTEGER,
    "start_year" INTEGER,
    "start_month" INTEGER,
    "start_abs" INTEGER,
    "end_year" INTEGER,
    "end_month" INTEGER,
    "end_abs" INTEGER,
    "summary" TEXT,
    "span_start_abs" INTEGER GENERATED ALWAYS AS (COALESCE("start_abs", "at_abs")) STORED,
    "span_end_abs" INTEGER GENERATED ALWAYS AS (COALESCE("end_abs", "at_abs")) STORED,
    "span" int4range GENERATED ALWAYS AS (
        int4range(
            COALESCE("start_abs", "at_abs"),
            COALESCE("end_abs", "at_abs"),
            '[]'
        )
    ) STORED,

    CONSTRAINT "events_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "events_time_check" CHECK (
        "at_abs" IS NOT NULL OR ("start_abs" IS NOT NULL AND "end_abs" IS NOT NULL)
    )
);

CREATE TABLE "event_dynasties" (
    "event_id" TEXT NOT NULL,
    "dynasty_id" TEXT NOT NULL,

    CONSTRAINT "event_dynasties_pkey" PRIMARY KEY ("event_id","dynasty_id")
);

CREATE TABLE "event_participants" (
    "event_id" TEXT NOT NULL,
    "person_id" TEXT NOT NULL,

    CONSTRAINT "event_participants_pkey" PRIMARY KEY ("event_id","person_id")
);

CREATE TABLE "relations" (
    "id" TEXT NOT NULL,
    "from_type" TEXT NOT NULL,
    "from_id" TEXT NOT NULL,
    "to_type" TEXT NOT NULL,
    "to_id" TEXT NOT NULL,
    "kind" TEXT NOT NULL,

    CONSTRAINT "relations_pkey" PRIMARY KEY ("id")
);

-- Indexes
CREATE INDEX "persons_birth_year_idx" ON "persons"("birth_year");
CREATE INDEX "persons_death_year_idx" ON "persons"("death_year");
CREATE INDEX "persons_name_idx" ON "persons"("name");

CREATE INDEX "dynasties_start_year_idx" ON "dynasties"("start_year");
CREATE INDEX "dynasties_end_year_idx" ON "dynasties"("end_year");
CREATE INDEX "dynasties_scope_start_abs_end_abs_idx" ON "dynasties"("scope", "start_abs", "end_abs");
CREATE INDEX "dynasties_span_gist_idx" ON "dynasties" USING GIST ("span");

CREATE INDEX "reigns_start_year_idx" ON "reigns"("start_year");
CREATE INDEX "reigns_end_year_idx" ON "reigns"("end_year");
CREATE INDEX "reigns_dynasty_id_idx" ON "reigns"("dynasty_id");
CREATE INDEX "reigns_person_id_idx" ON "reigns"("person_id");
CREATE INDEX "reigns_span_gist_idx" ON "reigns" USING GIST ("span");

CREATE INDEX "era_names_start_year_idx" ON "era_names"("start_year");
CREATE INDEX "era_names_end_year_idx" ON "era_names"("end_year");
CREATE INDEX "era_names_reign_id_idx" ON "era_names"("reign_id");
CREATE INDEX "era_names_start_abs_idx" ON "era_names"("start_abs");
CREATE INDEX "era_names_end_abs_idx" ON "era_names"("end_abs");

CREATE INDEX "events_at_year_idx" ON "events"("at_year");
CREATE INDEX "events_start_year_idx" ON "events"("start_year");
CREATE INDEX "events_end_year_idx" ON "events"("end_year");
CREATE INDEX "events_span_gist_idx" ON "events" USING GIST ("span");

CREATE UNIQUE INDEX "relations_from_type_from_id_to_type_to_id_kind_key"
    ON "relations"("from_type", "from_id", "to_type", "to_id", "kind");

-- ForeignKeys
ALTER TABLE "reigns" ADD CONSTRAINT "reigns_dynasty_id_fkey"
    FOREIGN KEY ("dynasty_id") REFERENCES "dynasties"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "reigns" ADD CONSTRAINT "reigns_person_id_fkey"
    FOREIGN KEY ("person_id") REFERENCES "persons"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "era_names" ADD CONSTRAINT "era_names_reign_id_fkey"
    FOREIGN KEY ("reign_id") REFERENCES "reigns"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "event_dynasties" ADD CONSTRAINT "event_dynasties_event_id_fkey"
    FOREIGN KEY ("event_id") REFERENCES "events"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "event_dynasties" ADD CONSTRAINT "event_dynasties_dynasty_id_fkey"
    FOREIGN KEY ("dynasty_id") REFERENCES "dynasties"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "event_participants" ADD CONSTRAINT "event_participants_event_id_fkey"
    FOREIGN KEY ("event_id") REFERENCES "events"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "event_participants" ADD CONSTRAINT "event_participants_person_id_fkey"
    FOREIGN KEY ("person_id") REFERENCES "persons"("id") ON DELETE CASCADE ON UPDATE CASCADE;
