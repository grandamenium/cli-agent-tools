---
name: ngrok-cli
description: Use ngrok to create secure tunnels to localhost, exposing local servers to the internet for webhook testing, demos, and remote access.
---

# ngrok

Secure tunneling to localhost. Expose local servers to the internet for webhooks, demos, and testing.

- **Official site:** https://ngrok.com
- **Docs:** https://ngrok.com/docs

## Authentication

```bash
ngrok config add-authtoken YOUR_TOKEN     # Set auth token (one-time)
```

## Common Commands

### HTTP Tunnels
```bash
ngrok http 3000                            # Tunnel to localhost:3000
ngrok http 8080                            # Tunnel to localhost:8080
ngrok http https://localhost:3000          # Tunnel to HTTPS local server
ngrok http --url=myapp.ngrok.io 3000      # Custom subdomain (paid)
```

### TCP Tunnels
```bash
ngrok tcp 22                               # Tunnel SSH
ngrok tcp 5432                             # Tunnel PostgreSQL
```

### Configuration
```bash
ngrok http 3000 --basic-auth="user:pass"  # Add basic auth
ngrok http 3000 --inspect=false           # Disable inspection
ngrok http 3000 --region=eu               # European region
```

### Inspection
```bash
# Web interface at http://127.0.0.1:4040 while tunnel is running
ngrok http 3000  # Then open http://127.0.0.1:4040 for request inspector
```

### API
```bash
ngrok api endpoints list                   # List active endpoints
ngrok api tunnels list                     # List active tunnels
```

## Agent Best Practices

- ngrok runs as a foreground process - use `&` or run in separate terminal
- The inspection UI at localhost:4040 shows all requests (useful for webhook debugging)
- Use `--log=stdout --log-format=json` for parseable log output
- Free tier provides random URLs that change each restart
- Use `ngrok http` for webhook testing (Stripe, GitHub, etc.)
- Kill the process to close the tunnel
- Parse the tunnel URL from the API: `curl -s localhost:4040/api/tunnels | jq '.tunnels[0].public_url'`

## Example Workflows

### Expose local server for webhook testing
```bash
ngrok http 3000 &
sleep 2
TUNNEL_URL=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
echo "Tunnel: $TUNNEL_URL"
# Configure webhook provider to send to $TUNNEL_URL/webhook
```

### Expose local dev server for mobile testing
```bash
ngrok http 3000
# Share the https URL with mobile device on same network
```
