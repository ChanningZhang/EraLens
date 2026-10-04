import cors from "@fastify/cors";
import fastifyStatic from "@fastify/static";
import Fastify from "fastify";
import path from "node:path";
import { openApiDatabase } from "./db.js";
import { registerRoutes } from "./routes/index.js";

const port = Number(process.env.PORT ?? 3001);
const host = process.env.HOST ?? "0.0.0.0";

const app = Fastify({ logger: true });
const database = await openApiDatabase();

await app.register(cors, { origin: true });
await app.register(
  async (api) => {
    await registerRoutes(api, database.repository, database.settings, database.contentInfo);
  },
  { prefix: "/api" },
);

const staticDir = process.env.STATIC_DIR;
if (staticDir) {
  const root = path.resolve(staticDir);
  await app.register(fastifyStatic, { root, wildcard: false });
  app.setNotFoundHandler((request, reply) => {
    if (request.url.startsWith("/api")) {
      reply.code(404).send({ error: "Not found" });
      return;
    }
    return reply.sendFile("index.html", root);
  });
}

app.addHook("onClose", async () => {
  await database.repository.close();
  database.contentProvider.close();
  database.settings.close();
});

try {
  await app.listen({ port, host });
  console.log(`API listening on http://${host}:${port}`);
} catch (error) {
  app.log.error(error);
  await app.close();
  process.exit(1);
}
