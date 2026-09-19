import {
  absMonth,
  formatAppellationCsv,
  DynastySchema,
  EventSchema,
  PersonSchema,
  ReignSchema,
  RelationSchema,
  type Dynasty,
  type Event,
  type Person,
  type Reign,
  type Relation,
} from "@eralens/shared";
import { readFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { prisma } from "./db.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const seedDir = path.resolve(__dirname, "../../../data/seed");

async function readSeed<T>(filename: string, schema: { parse: (data: unknown) => T }): Promise<T> {
  const raw = await readFile(path.join(seedDir, filename), "utf8");
  return schema.parse(JSON.parse(raw));
}

function assertAbs(label: string, year: number, month: number, expected: number) {
  const actual = absMonth(year, month);
  if (actual !== expected) {
    throw new Error(`${label}: abs mismatch expected ${expected}, got ${actual}`);
  }
}

function parseRef(raw: string): { type: string; id: string } {
  const [type, ...rest] = raw.split(":");
  return { type: type!, id: rest.join(":") };
}

async function main() {
  const persons = await readSeed<Person[]>("persons.json", PersonSchema.array());
  const dynasties = await readSeed<Dynasty[]>("dynasties.json", DynastySchema.array());
  const reigns = await readSeed<Reign[]>("reigns.json", ReignSchema.array());
  const events = await readSeed<Event[]>("events.json", EventSchema.array());
  const relations = await readSeed<Relation[]>("relations.json", RelationSchema.array());

  for (const dynasty of dynasties) {
    assertAbs(`dynasty ${dynasty.id} start`, dynasty.start.year, dynasty.start.month, dynasty.startAbs);
    assertAbs(`dynasty ${dynasty.id} end`, dynasty.end.year, dynasty.end.month, dynasty.endAbs);
  }
  for (const reign of reigns) {
    assertAbs(`reign ${reign.id} start`, reign.start.year, reign.start.month, reign.startAbs);
    assertAbs(`reign ${reign.id} end`, reign.end.year, reign.end.month, reign.endAbs);
  }
  for (const event of events) {
    if (event.at && event.atAbs != null) {
      assertAbs(`event ${event.id} at`, event.at.year, event.at.month, event.atAbs);
    }
    if (event.start && event.startAbs != null) {
      assertAbs(`event ${event.id} start`, event.start.year, event.start.month, event.startAbs);
    }
    if (event.end && event.endAbs != null) {
      assertAbs(`event ${event.id} end`, event.end.year, event.end.month, event.endAbs);
    }
  }

  await prisma.$transaction(async (tx) => {
    await tx.eventParticipant.deleteMany();
    await tx.eventDynasty.deleteMany();
    await tx.relation.deleteMany();
    await tx.event.deleteMany();
    await tx.reign.deleteMany();
    await tx.dynasty.deleteMany();
    await tx.person.deleteMany();

    for (const person of persons) {
      await tx.person.create({
        data: {
          id: person.id,
          name: person.name,
          birthYear: person.birth?.year,
          birthMonth: person.birth?.month,
          deathYear: person.death?.year,
          deathMonth: person.death?.month,
          roles: person.roles,
          bio: person.bio,
          links: person.links,
          posthumousName: formatAppellationCsv(person.posthumousNames),
          templeName: formatAppellationCsv(person.templeNames),
        },
      });
    }

    for (const dynasty of dynasties) {
      await tx.dynasty.create({
        data: {
          id: dynasty.id,
          name: dynasty.name,
          altNames: dynasty.altNames,
          scope: dynasty.scope,
          region: dynasty.region,
          startYear: dynasty.start.year,
          startMonth: dynasty.start.month,
          endYear: dynasty.end.year,
          endMonth: dynasty.end.month,
          startAbs: dynasty.startAbs,
          endAbs: dynasty.endAbs,
          precision: dynasty.precision,
          colorToken: dynasty.colorToken,
          orthodoxFromAbs: dynasty.orthodoxFromAbs,
          orthodoxEndAbs: dynasty.orthodoxEndAbs,
          parentId: dynasty.parentId,
          groupId: dynasty.groupId,
          note: dynasty.note,
        },
      });
    }

    for (const reign of reigns) {
      await tx.reign.create({
        data: {
          id: reign.id,
          dynastyId: reign.dynastyId,
          personId: reign.personId,
          title: reign.title,
          preferredAppellation: reign.preferredAppellation,
          eraNames: formatAppellationCsv(reign.eraNames),
          startYear: reign.start.year,
          startMonth: reign.start.month,
          startDay: reign.start.day,
          endYear: reign.end.year,
          endMonth: reign.end.month,
          endDay: reign.end.day,
          startAbs: reign.startAbs,
          endAbs: reign.endAbs,
          precision: reign.precision,
        },
      });
    }

    for (const event of events) {
      await tx.event.create({
        data: {
          id: event.id,
          name: event.name,
          kind: event.kind,
          timeMode: event.timeMode,
          precision: event.precision,
          dateNote: event.dateNote,
          atYear: event.at?.year,
          atMonth: event.at?.month,
          atAbs: event.atAbs,
          startYear: event.start?.year,
          startMonth: event.start?.month,
          startAbs: event.startAbs,
          endYear: event.end?.year,
          endMonth: event.end?.month,
          endAbs: event.endAbs,
          summary: event.summary,
          dynasties: {
            create: event.dynastyIds.map((dynastyId) => ({ dynastyId })),
          },
          participants: {
            create: event.participantIds.map((personId) => ({ personId })),
          },
        },
      });
    }

    for (const relation of relations) {
      const from = parseRef(relation.fromRef);
      const to = parseRef(relation.toRef);
      await tx.relation.create({
        data: {
          id: relation.id,
          fromType: from.type,
          fromId: from.id,
          toType: to.type,
          toId: to.id,
          kind: relation.kind,
          atYear: relation.at?.year ?? null,
          atMonth: relation.at?.month ?? null,
          atAbs: relation.atAbs ?? null,
          precision: relation.precision ?? null,
          eventId: relation.eventId ?? null,
        },
      });
    }
  });

  console.log(
    `Seeded ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`,
  );
}

main()
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
