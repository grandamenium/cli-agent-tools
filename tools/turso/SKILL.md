---
name: turso-cli
description: Use the Turso CLI to create and manage SQLite edge databases, manage groups, replicate to regions, and query data. Use this instead of the Turso MCP server.
---

# Turso CLI

Official CLI for Turso. Manage libSQL/SQLite databases at the edge with global replication.

- **Official repo:** https://github.com/tursodatabase/turso-cli
- **Docs:** https://docs.turso.tech/cli

## Authentication

```bash
turso auth login                          # Browser-based login
turso auth token                          # Print auth token
turso auth whoami                         # Check current user
```

## Common Commands

### Databases
```bash
turso db create my-db                     # Create database
turso db create my-db --group default     # Create in specific group
turso db list                             # List databases
turso db show my-db                       # Show database details (URL, regions)
turso db destroy my-db                    # Delete database
turso db shell my-db                      # Interactive SQL shell
turso db shell my-db "SELECT * FROM users LIMIT 10"  # Run query directly
```

### Tokens
```bash
turso db tokens create my-db              # Create auth token for database
turso db tokens create my-db --expiration 7d  # Token with expiration
turso db tokens invalidate my-db          # Invalidate all tokens
```

### Groups
```bash
turso group create my-group               # Create group
turso group list                          # List groups
turso group locations add my-group lax    # Add region to group
turso group locations list my-group       # List group regions
```

### Replication
```bash
turso db replicate my-db lax              # Add replica in region
turso db show my-db --instance-urls       # Show all replica URLs
```

## Agent Best Practices

- Use `turso db shell` for quick queries and debugging
- Create database tokens with expiration for application use
- Use groups to manage replication strategy for multiple databases
- Use `turso db show` to get the connection URL for application config
- Use `--json` flag where available for machine-readable output
- Prefer creating databases in groups for consistent replication

## Example Workflows

### Create database and get connection info
```bash
turso db create my-app-db
turso db show my-app-db  # Get URL
turso db tokens create my-app-db  # Get auth token
```

### Run a migration
```bash
turso db shell my-db < migrations/001_create_tables.sql
```
