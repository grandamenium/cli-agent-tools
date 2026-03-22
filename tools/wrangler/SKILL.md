---
name: wrangler-cli
description: Use Wrangler (Cloudflare Workers CLI) to develop, test, and deploy edge functions, manage KV stores, R2 buckets, and D1 databases. Use this instead of the Cloudflare MCP server.
---

# Wrangler (Cloudflare Workers CLI)

Official CLI for Cloudflare Workers. Build and deploy edge functions, manage KV, R2, D1, and Queues.

- **Official repo:** https://github.com/cloudflare/workers-sdk
- **Docs:** https://developers.cloudflare.com/workers/wrangler/

## Authentication

```bash
npx wrangler login                        # Browser-based OAuth
npx wrangler whoami                       # Check current user
# Or set CLOUDFLARE_API_TOKEN env var
```

## Common Commands

### Development
```bash
npx wrangler init my-worker               # Create new worker
npx wrangler dev                           # Start local dev server
npx wrangler dev --local                   # Fully local (no Cloudflare)
npx wrangler dev --port 8787              # Custom port
```

### Deployments
```bash
npx wrangler deploy                        # Deploy worker
npx wrangler deploy --env staging          # Deploy to environment
npx wrangler deployments list              # List deployments
npx wrangler rollback                      # Rollback deployment
npx wrangler tail                          # Live tail logs
```

### KV Store
```bash
npx wrangler kv namespace list
npx wrangler kv namespace create MY_KV
npx wrangler kv key put --namespace-id ID "key" "value"
npx wrangler kv key get --namespace-id ID "key"
npx wrangler kv key list --namespace-id ID
npx wrangler kv key delete --namespace-id ID "key"
```

### R2 (Object Storage)
```bash
npx wrangler r2 bucket list
npx wrangler r2 bucket create my-bucket
npx wrangler r2 object put my-bucket/file.txt --file=./file.txt
npx wrangler r2 object get my-bucket/file.txt
```

### D1 (SQLite Database)
```bash
npx wrangler d1 create my-db
npx wrangler d1 list
npx wrangler d1 execute my-db --command "SELECT * FROM users LIMIT 10"
npx wrangler d1 execute my-db --file ./schema.sql
npx wrangler d1 migrations create my-db add_users
npx wrangler d1 migrations apply my-db
```

### Secrets
```bash
npx wrangler secret put SECRET_NAME        # Interactive value input
npx wrangler secret list
npx wrangler secret delete SECRET_NAME
```

## Agent Best Practices

- Use `npx wrangler` to always use the project-local version
- Use `wrangler dev --local` for fast iteration without Cloudflare calls
- Use `wrangler tail` to debug production issues in real-time
- Use `wrangler d1 execute` for quick database queries
- Set secrets before deploying - they persist across deployments
- Use `--env` flag to manage staging/production environments

## Example Workflows

### Create and deploy a worker
```bash
npx wrangler init my-api
cd my-api
npx wrangler dev  # Test locally
npx wrangler deploy
```

### Query D1 database
```bash
npx wrangler d1 execute my-db --command "SELECT COUNT(*) FROM users" --json
```
