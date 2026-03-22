---
name: resend-cli
description: Use the Resend CLI to send emails, manage domains, API keys, and audiences from the terminal. Use this instead of the Resend MCP server.
---

# Resend CLI

Official CLI for Resend. Send transactional emails, manage domains, API keys, and contacts.

- **Official repo:** https://github.com/resend/resend-cli
- **Docs:** https://resend.com/docs/cli

## Authentication

```bash
resend login                              # Browser-based login, creates API key
```

## Common Commands

### Sending Emails
```bash
resend emails send --from "you@yourdomain.com" --to "user@example.com" --subject "Hello" --text "Body text"
resend emails send --from "you@yourdomain.com" --to "user@example.com" --subject "Hello" --html "<h1>Hi</h1>"
resend emails get EMAIL_ID                # Get email details
```

### Domains
```bash
resend domains list                       # List verified domains
resend domains create --name example.com  # Add domain
resend domains verify --id DOMAIN_ID      # Check verification status
resend domains delete --id DOMAIN_ID      # Remove domain
```

### API Keys
```bash
resend api-keys list                      # List API keys
resend api-keys create --name "Production"
resend api-keys delete --id KEY_ID
```

### Audiences and Contacts
```bash
resend audiences list
resend audiences create --name "Newsletter"
resend contacts list --audience-id AUD_ID
resend contacts create --audience-id AUD_ID --email "user@example.com" --first-name "John"
```

## Agent Best Practices

- Always verify domain ownership before sending emails
- Use `--html` for rich emails, `--text` for plain text
- Use audience/contacts for managing mailing lists
- Check domain verification status with `resend domains list`
- Use the SDK (npm package `resend`) for programmatic sending in applications
- The CLI is best for testing and one-off sends; use the API for production flows

## Example Workflows

### Send a test email
```bash
resend emails send \
  --from "test@yourdomain.com" \
  --to "you@gmail.com" \
  --subject "Test from CLI" \
  --text "This is a test email sent from the Resend CLI."
```

### Verify domain setup
```bash
resend domains list
resend domains verify --id DOMAIN_ID
```
