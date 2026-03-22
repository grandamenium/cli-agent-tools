---
name: fly-cli
description: Use the Fly.io CLI (flyctl) to deploy applications to edge locations, manage machines, volumes, secrets, and databases.
---

# Fly.io CLI (flyctl / fly)

Official CLI for Fly.io. Deploy apps globally to edge locations with Firecracker VMs.

- **Official repo:** https://github.com/superfly/flyctl
- **Docs:** https://fly.io/docs/flyctl/

## Authentication

```bash
fly auth login                            # Browser-based login
fly auth token                            # Print auth token
fly auth whoami                           # Check current user
```

## Common Commands

### Apps
```bash
fly launch                                # Create and configure new app
fly deploy                                # Deploy current directory
fly deploy --image my-registry/my-app:v1  # Deploy specific image
fly apps list
fly status                                # Current app status
fly open                                  # Open app in browser
```

### Machines
```bash
fly machine list
fly machine start MACHINE_ID
fly machine stop MACHINE_ID
fly machine restart MACHINE_ID
fly machine status MACHINE_ID
```

### Scaling
```bash
fly scale count 3                         # Set instance count
fly scale vm shared-cpu-1x                # Change VM size
fly scale memory 512                      # Set memory (MB)
fly scale show                            # Show current scale
fly regions add ord                       # Add region
fly regions list                          # List regions
```

### Secrets
```bash
fly secrets set DATABASE_URL=postgres://...
fly secrets list
fly secrets unset DATABASE_URL
```

### Logs and SSH
```bash
fly logs                                  # Stream logs
fly ssh console                           # SSH into running machine
fly ssh console -C "ls /app"              # Run command via SSH
```

### Databases
```bash
fly postgres create                       # Create managed Postgres
fly postgres list
fly postgres connect -a my-db             # Connect to Postgres
```

### Volumes
```bash
fly volumes create my_data --size 10      # Create 10GB volume
fly volumes list
```

## Agent Best Practices

- Use `fly status` to check app health and deployment status
- Use `fly deploy --strategy rolling` for zero-downtime deploys
- Use `fly logs` to debug issues after deployment
- Set secrets before deploying: `fly secrets set` triggers a redeploy
- Use `fly ssh console -C "command"` for one-off remote commands
- Use `fly scale count` to manage instance count per region

## Example Workflows

### Deploy and verify
```bash
fly deploy
fly status
fly logs --instance INSTANCE_ID
```

### Scale to multiple regions
```bash
fly regions add lax ord ams
fly scale count 2
```
