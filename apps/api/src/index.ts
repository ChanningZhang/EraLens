import cors from "@fastify/cors";
import Fastify from "fastify";
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

try {
  await prisma.$connect();
  await app.listen({ port, host });
  console.log(`API listening on http://${host}:${port}`);
} catch (error) {
  app.log.error(error);
  process.exit(1);
}
