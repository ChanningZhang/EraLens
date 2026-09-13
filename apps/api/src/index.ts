import cors from "@fastify/cors";
import fastifyStatic from "@fastify/static";
import Fastify from "fastify";
import path from "node:path";
import { prisma } from "./db.js";
import { registerRoutes } from "./routes/index.js";

const port = Number(process.env.PORT ?? 3001);
const host = process.env.HOST ?? "0.0.0.0";

const app = Fastify({ logger: true });

await app.register(cors, { origin: true });
await app.register(
  async (api) => {
    await registerRoutes(api);
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

try {
  await prisma.$connect();
  await app.listen({ port, host });
  console.log(`API listening on http://${host}:${port}`);
} catch (error) {
  app.log.error(error);
  process.exit(1);
}
