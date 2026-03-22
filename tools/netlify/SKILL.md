---
name: netlify-cli
description: Use the Netlify CLI to deploy sites, manage serverless functions, configure environment variables, and manage forms. Use this instead of the Netlify MCP server.
---

# Netlify CLI

Official CLI for Netlify. Deploy sites, manage functions, env vars, and forms.

- **Official repo:** https://github.com/netlify/cli
- **Docs:** https://docs.netlify.com/cli/get-started/

## Authentication

```bash
netlify login                             # Browser-based login
netlify status                            # Check auth and linked site
```

## Common Commands

### Deployments
```bash
netlify deploy                            # Deploy draft
netlify deploy --prod                     # Deploy to production
netlify deploy --dir=./dist               # Deploy specific directory
netlify deploy --build                    # Build then deploy
netlify watch                             # Watch for deploy completion
```

### Sites
```bash
netlify sites:list                        # List all sites
netlify sites:create --name my-site       # Create new site
netlify link                              # Link to existing site
netlify unlink                            # Unlink current directory
netlify open                              # Open site in browser
netlify open:admin                        # Open admin panel
```

### Dev Server
```bash
netlify dev                               # Start local dev server
netlify dev --port 8888                   # Custom port
netlify dev --live                        # Share via live tunnel
```

### Environment Variables
```bash
netlify env:set KEY value
netlify env:get KEY
netlify env:unset KEY
netlify env:list
netlify env:import .env                   # Import from file
```

### Functions
```bash
netlify functions:create my-func          # Scaffold new function
netlify functions:serve                   # Serve functions locally
netlify functions:invoke my-func          # Invoke locally
netlify functions:list                    # List deployed functions
```

## Agent Best Practices

- Use `netlify deploy` (without --prod) first to get a preview URL
- Use `netlify dev` for local development with serverless functions
- Use `--json` flag for machine-readable output
- Check `netlify status` to confirm linked site before deploying
- Use `netlify env:import .env` to sync environment from file
- Use `--dir` flag to explicitly specify the build output directory

## Example Workflows

### Deploy and preview
```bash
URL=$(netlify deploy --dir=./dist --json | jq -r '.deploy_url')
echo "Preview: $URL"
```

### Deploy to production
```bash
netlify deploy --prod --dir=./dist
```
