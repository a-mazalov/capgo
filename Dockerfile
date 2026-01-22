FROM oven/bun:1.3 AS build
WORKDIR /app

# Deps
COPY package.json bun.* bunfig.* ./
RUN bun install --frozen-lockfile

# Build
COPY . .
RUN bun run build

# Runtime
FROM nginx:1.25-alpine AS runtime
WORKDIR /usr/share/nginx/html

COPY --from=build /app/dist/ ./

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
