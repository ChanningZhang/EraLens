# syntax=docker/dockerfile:1

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
COPY data/seed data/seed
COPY apps/web apps/web
ENV VITE_DATA_SOURCE=http
ENV VITE_API_BASE=/api
RUN pnpm --filter @eralens/web build

COPY apps/api apps/api
RUN pnpm --filter @eralens/api db:generate

FROM base AS runner
RUN apk add --no-cache postgresql-client
WORKDIR /app

ENV PORT=8080
ENV HOST=0.0.0.0
ENV STATIC_DIR=/app/apps/web/dist

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/api/package.json apps/api/
COPY packages/shared/package.json packages/shared/
RUN pnpm install --frozen-lockfile

COPY tsconfig.base.json ./
COPY packages/shared packages/shared
COPY apps/api apps/api
COPY data/seed data/seed
COPY --from=builder /app/apps/web/dist apps/web/dist
RUN pnpm --filter @eralens/api db:generate

ENV NODE_ENV=production

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
CMD ["pnpm", "--filter", "@eralens/api", "start"]
