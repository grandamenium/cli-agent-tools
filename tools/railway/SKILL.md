---
name: railway-cli
description: Use the Railway CLI to deploy services, manage environment variables, view logs, and configure projects on Railway.app. Use this instead of the Railway MCP server.
---

# Railway CLI

Official CLI for Railway. Deploy apps, manage services, databases, and environment variables.

- **Official repo:** https://github.com/railwayapp/cli
- **Docs:** https://docs.railway.app/reference/cli-api

## Authentication

```bash
railway login             # Browser-based login
railway login --browserless  # Token-based login
railway whoami            # Check current user
```

## Common Commands

### Projects
```bash
railway init                  # Create new project
railway link                  # Link to existing project
railway status                # Show current project/environment
railway list                  # List all projects
```

### Deployments
```bash
railway up                    # Deploy current directory
railway up --detach           # Deploy without following logs
railway logs                  # View service logs
railway logs --follow         # Stream logs in real-time
```

### Environment Variables
```bash
railway variables             # List variables
railway variables set KEY=value
railway variables delete KEY
```

### Services
```bash
railway service               # Select active service
railway add                   # Add a new service (database, etc.)
railway domain                # Generate a domain for the service
```

### Shell
```bash
railway shell                 # Open shell with Railway env vars loaded
railway run <command>         # Run command with Railway env vars
```

## Agent Best Practices

- Use `railway run` to execute commands with the project's env vars injected
- Check `railway status` to confirm you're linked to the correct project/environment
- Use `railway logs --follow` for debugging deployment issues
- Use `railway variables` to inspect and manage env vars without the dashboard
- Deploy with `railway up --detach` for non-blocking deploys

## Example Workflows

### Deploy and check logs
```bash
railway up --detach
railway logs --num 50
```

### Run database migration with Railway env vars
```bash
railway run npx prisma migrate deploy
```
