---
name: vercel-cli
description: Use the Vercel CLI to deploy applications, manage environment variables, configure domains, and inspect deployments. Use this instead of the Vercel MCP server.
---

# Vercel CLI

Official CLI for Vercel. Deploy frontend apps, manage env vars, domains, and inspect builds.

- **Official repo:** https://github.com/vercel/vercel
- **Docs:** https://vercel.com/docs/cli

## Authentication

```bash
vercel login              # Interactive login
vercel login --token xxx  # Use token directly
vercel whoami             # Check current user
```

## Common Commands

### Deployments
```bash
vercel                        # Deploy current directory (preview)
vercel --prod                 # Deploy to production
vercel deploy --prebuilt      # Deploy pre-built output
vercel ls                     # List recent deployments
vercel inspect <url>          # Inspect a deployment
vercel logs <url>             # View deployment logs
vercel redeploy               # Redeploy latest
vercel rollback               # Rollback to previous production deployment
```

### Environment Variables
```bash
vercel env ls                          # List all env vars
vercel env add SECRET_KEY production   # Add env var (interactive value input)
vercel env rm SECRET_KEY production    # Remove env var
vercel env pull .env.local             # Pull env vars to local file
```

### Domains
```bash
vercel domains ls                    # List domains
vercel domains add example.com       # Add domain
vercel domains inspect example.com   # Inspect domain config
```

### Projects
```bash
vercel project ls                # List projects
vercel link                      # Link local dir to Vercel project
vercel project rm my-project     # Remove project
```

## Agent Best Practices

- Use `vercel --confirm` to skip interactive prompts in automated flows
- Always use `vercel env pull` to sync env vars locally before working
- Check deployment status with `vercel inspect` after deploying
- Use `vercel --prod` explicitly for production deploys (default is preview)
- Pipe `vercel ls --json` through jq for structured output

## Example Workflows

### Deploy and get URL
```bash
URL=$(vercel --confirm --prod 2>&1 | tail -1)
echo "Deployed to: $URL"
```

### Check deployment status
```bash
vercel ls --json | jq '.[0] | {url, state, created}'
```
