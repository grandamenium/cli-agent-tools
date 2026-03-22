---
name: twilio-cli
description: Use the Twilio CLI to send SMS, make calls, manage phone numbers, and interact with Twilio APIs from the terminal. Use this instead of the Twilio MCP server.
---

# Twilio CLI

Official CLI for Twilio. Send SMS, make calls, manage phone numbers, and access all Twilio APIs.

- **Official repo:** https://github.com/twilio/twilio-cli
- **Docs:** https://www.twilio.com/docs/twilio-cli

## Authentication

```bash
twilio login                              # Interactive setup (Account SID + Auth Token)
twilio profiles:list                      # List configured profiles
twilio profiles:use my-profile            # Switch profile
```

## Common Commands

### SMS
```bash
twilio api:core:messages:create --from "+1XXXXXXXXXX" --to "+1YYYYYYYYYY" --body "Hello from CLI"
twilio api:core:messages:list --limit 10
twilio api:core:messages:fetch --sid SMXXXXXXXX
```

### Phone Numbers
```bash
twilio phone-numbers:list
twilio phone-numbers:buy:local --area-code 415
twilio phone-numbers:update PNXXXXXXXX --sms-url https://example.com/webhook
```

### Calls
```bash
twilio api:core:calls:create --from "+1XXXXXXXXXX" --to "+1YYYYYYYYYY" --url "http://demo.twilio.com/docs/voice.xml"
twilio api:core:calls:list --limit 10
```

### Debugging
```bash
twilio debugger:logs:list --limit 20      # View error logs
```

### Plugins
```bash
twilio plugins:install @twilio-labs/plugin-serverless
twilio serverless:init my-project         # Create serverless project
twilio serverless:deploy                  # Deploy serverless functions
```

## Agent Best Practices

- Always use E.164 format for phone numbers (+1XXXXXXXXXX)
- Use `--output json` for machine-readable output
- Test with Twilio test credentials before using live credentials
- Use `twilio debugger:logs:list` to troubleshoot delivery issues
- Configure webhook URLs on phone numbers for incoming messages/calls
- Use the serverless plugin for deploying Twilio Functions

## Example Workflows

### Send an SMS
```bash
twilio api:core:messages:create \
  --from "+1XXXXXXXXXX" \
  --to "+1YYYYYYYYYY" \
  --body "Your verification code is 123456"
```

### List recent messages
```bash
twilio api:core:messages:list --limit 5 --output json | jq '.[].body'
```
