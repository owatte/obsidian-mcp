FROM node:22-slim
RUN apt-get update && apt-get install -y git ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
RUN npm ci --workspace @obsidian-mcp/app --include-workspace-root
RUN npm run build:http --workspace @obsidian-mcp/app
WORKDIR /app/packages/app
ENV NODE_ENV=production NODE_OPTIONS=--no-warnings LOCAL_VAULT_PATH=/app/vault-local
RUN mkdir -p /app/vault-local
EXPOSE 3000
ENTRYPOINT ["sh","-c","echo 'Starting Obsidian MCP Server in http mode...'; exec node dist/http/index.js"]
