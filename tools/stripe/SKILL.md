---
name: stripe-cli
description: Use the Stripe CLI to manage payments, listen to webhooks, trigger test events, and interact with your Stripe account from the terminal. Use this instead of the Stripe MCP server.
---

# Stripe CLI

Official CLI for Stripe. Test webhooks locally, manage resources, and trigger events without the dashboard.

- **Official repo:** https://github.com/stripe/stripe-cli
- **Docs:** https://docs.stripe.com/stripe-cli

## Authentication

```bash
stripe login                    # Opens browser for auth
stripe login --api-key sk_test_xxx  # Use API key directly
```

## Common Commands

### Webhook Testing
```bash
stripe listen                                    # Forward all events to default endpoint
stripe listen --forward-to localhost:3000/webhook # Forward to local server
stripe listen --events payment_intent.succeeded   # Filter specific events
stripe trigger payment_intent.succeeded           # Trigger a test event
stripe trigger customer.subscription.created      # Test subscription flow
```

### Resources
```bash
stripe customers list --limit 5
stripe customers create --name "Test User" --email test@example.com
stripe payment_intents create --amount 2000 --currency usd
stripe products list
stripe prices list --product prod_xxx
stripe subscriptions list --customer cus_xxx
```

### Logs and Events
```bash
stripe logs tail                # Stream API logs in real-time
stripe events list --limit 10
stripe events resend evt_xxx
```

### Fixtures
```bash
stripe fixtures path/to/fixture.json   # Run a fixture file for test data
```

## Agent Best Practices

- Always use test mode keys (sk_test_*) for agent operations
- Use `--json` or pipe output through `jq` for structured data
- `stripe listen` runs as a long-lived process - run it in background
- Use `stripe trigger` to test webhook handlers without real transactions
- The `stripe logs tail` command is invaluable for debugging API issues
- Use `stripe resources` to discover available resource types

## Example Workflows

### Set up local webhook testing
```bash
stripe listen --forward-to localhost:3000/api/webhooks \
  --events checkout.session.completed,payment_intent.succeeded
```

### Create a test customer with subscription
```bash
CUSTOMER=$(stripe customers create --name "Test" -q --json | jq -r '.id')
stripe subscriptions create --customer "$CUSTOMER" --price price_xxx
```
