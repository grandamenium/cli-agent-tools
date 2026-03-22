---
name: planetscale-cli
description: Use the PlanetScale CLI (pscale) to manage MySQL databases with branching, deploy requests, and schema migrations. Use this instead of the PlanetScale MCP server.
---

# PlanetScale CLI (pscale)

Official CLI for PlanetScale. Manage MySQL databases with git-like branching and non-blocking schema changes.

- **Official repo:** https://github.com/planetscale/cli
- **Docs:** https://planetscale.com/docs/reference/planetscale-cli

## Authentication

```bash
pscale auth login                         # Browser-based login
pscale org list                           # List organizations
pscale org switch my-org                  # Switch organization
```

## Common Commands

### Databases
```bash
pscale database create my-db --region us-east
pscale database list
pscale database show my-db
pscale database delete my-db
```

### Branches
```bash
pscale branch create my-db feature-branch
pscale branch list my-db
pscale branch show my-db feature-branch
pscale branch delete my-db feature-branch
pscale branch diff my-db feature-branch   # Show schema diff
pscale branch schema my-db main           # Show branch schema
```

### Deploy Requests (like PRs for schema changes)
```bash
pscale deploy-request create my-db feature-branch
pscale deploy-request list my-db
pscale deploy-request show my-db 1
pscale deploy-request diff my-db 1        # Show schema changes
pscale deploy-request deploy my-db 1      # Apply changes to main
pscale deploy-request close my-db 1       # Close without deploying
```

### Shell and Connections
```bash
pscale shell my-db main                   # MySQL shell on main branch
pscale shell my-db feature-branch         # Shell on feature branch
pscale connect my-db main --port 3306     # Proxy connection (for apps)
```

### Passwords (connection strings)
```bash
pscale password create my-db main my-password
pscale password list my-db main
pscale password delete my-db main PASSWORD_ID
```

## Agent Best Practices

- Always make schema changes on branches, never directly on main
- Use deploy requests to review schema changes before applying
- Use `pscale shell` for quick queries and debugging
- Use `pscale connect` to create a local proxy for application connections
- Use `pscale branch diff` to verify schema changes before creating deploy requests
- Use `--format json` for machine-readable output

## Example Workflows

### Schema change workflow
```bash
pscale branch create my-db add-profiles
pscale shell my-db add-profiles
# CREATE TABLE profiles (id INT PRIMARY KEY AUTO_INCREMENT, ...);
pscale branch diff my-db add-profiles
pscale deploy-request create my-db add-profiles
pscale deploy-request deploy my-db 1
```

### Connect app to database locally
```bash
pscale connect my-db main --port 3306 &
# App connects to localhost:3306
```
