---
name: supabase-cli
description: Use the Supabase CLI to manage databases, run migrations, manage auth, storage, edge functions, and local development. Use this instead of the Supabase MCP server.
---

# Supabase CLI

Official CLI for Supabase. Manage PostgreSQL databases, auth, storage, edge functions, and local development.

- **Official repo:** https://github.com/supabase/cli
- **Docs:** https://supabase.com/docs/reference/cli

## Authentication

```bash
supabase login                            # Browser-based login
supabase link --project-ref PROJECT_REF   # Link to remote project
```

## Common Commands

### Local Development
```bash
supabase init                             # Initialize new project
supabase start                            # Start local Supabase stack
supabase stop                             # Stop local stack
supabase status                           # Show local service URLs/keys
supabase db reset                         # Reset local database
```

### Database & Migrations
```bash
supabase migration new create_users       # Create new migration
supabase migration list                   # List migrations
supabase db push                          # Push migrations to remote
supabase db pull                          # Pull remote schema as migration
supabase db diff --schema public          # Diff local vs remote
supabase db dump --data-only -f seed.sql  # Dump data
```

### Edge Functions
```bash
supabase functions new my-function        # Create new function
supabase functions serve my-function      # Serve locally
supabase functions deploy my-function     # Deploy to production
supabase functions list                   # List deployed functions
supabase functions delete my-function     # Delete function
```

### Type Generation
```bash
supabase gen types typescript --local > types/supabase.ts
supabase gen types typescript --linked > types/supabase.ts
```

### Secrets
```bash
supabase secrets set MY_SECRET=value
supabase secrets list
supabase secrets unset MY_SECRET
```

## Agent Best Practices

- Use `supabase status` to get local API URL and anon key
- Always create migrations for schema changes instead of modifying directly
- Use `supabase db diff` to check for drift between local and remote
- Use `supabase gen types` after schema changes to keep types in sync
- Run `supabase db reset` to test migrations from scratch
- Use `supabase functions serve` with `--env-file` for local secrets

## Example Workflows

### Create and apply a migration
```bash
supabase migration new add_profiles_table
# Edit the migration file in supabase/migrations/
supabase db reset  # Test locally
supabase db push   # Deploy to remote
```

### Generate TypeScript types
```bash
supabase gen types typescript --linked > src/types/database.ts
```
