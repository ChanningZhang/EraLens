FROM node:22-alpine AS base
RUN corepack enable && corepack prepare pnpm@9.15.4 --activate
WORKDIR /app

FROM base AS deps
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/api/package.json apps/api/
COPY apps/web/package.json apps/web/
COPY packages/shared/package.json packages/shared/
RUN pnpm install --frozen-lockfile

FROM deps AS builder
COPY tsconfig.base.json ./
COPY packages/shared packages/shared
COPY packages/data-access packages/data-access
COPY data/imports data/imports
COPY data/seed data/seed
COPY data/mobile/schema.sql data/mobile/versions.json data/mobile/
COPY apps/web apps/web
ENV VITE_DATA_SOURCE=http
ENV VITE_API_BASE=/api
RUN pnpm --filter @eralens/web build

COPY apps/api apps/api
RUN pnpm data:build && pnpm data:validate

FROM base AS runner
WORKDIR /app

ENV PORT=8080
ENV HOST=0.0.0.0
ENV STATIC_DIR=/app/apps/web/dist

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/api/package.json apps/api/
COPY packages/shared/package.json packages/shared/
COPY packages/data-access/package.json packages/data-access/
RUN pnpm install --frozen-lockfile

COPY tsconfig.base.json ./
COPY packages/shared packages/shared
COPY packages/data-access packages/data-access
COPY data/mobile/versions.json data/mobile/versions.json
COPY apps/api apps/api
COPY --from=builder /app/data/mobile/eralens-content.sqlite data/mobile/eralens-content.sqlite
COPY --from=builder /app/apps/web/dist apps/web/dist

ENV NODE_ENV=production

EXPOSE 8080
CMD ["pnpm", "--filter", "@eralens/api", "start"]
