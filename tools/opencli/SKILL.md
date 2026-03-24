---
name: opencli-cli
description: Use OpenCLI to turn any website, Electron app, or local tool into a CLI. 50+ adapters for social media, news, finance, and dev tools. Reuses Chrome login sessions with zero credentials. AI-agent ready with structured output.
---

# OpenCLI

Universal CLI hub that makes any website, Electron app, or local binary scriptable from the terminal. Reuses Chrome login sessions for zero-credential automation.

- **Official repo:** https://github.com/jackwener/opencli
- **Docs:** https://github.com/jackwener/opencli/blob/main/README.md

## Common Commands

### Discovery
```bash
opencli list                    # All 50+ available commands
opencli list -f yaml            # Structured registry (for AI agents)
opencli doctor                  # Diagnose daemon + extension status
```

### Social & Content (browser, uses Chrome login)
```bash
opencli twitter trending --limit 20
opencli twitter bookmarks --limit 10
opencli reddit hot --subreddit programming --limit 30
opencli reddit search "ai agents" --sort top --time month
opencli youtube trending --limit 10
opencli instagram feed --limit 20
opencli tiktok trending --limit 15
opencli linkedin feed --limit 10
```

### News & Research (public API, no login needed)
```bash
opencli hackernews top --limit 20
opencli hackernews best --limit 10
opencli stackoverflow search "claude code" --limit 10
opencli arxiv search "large language models" --limit 5
opencli wikipedia search "artificial intelligence"
opencli devto latest --limit 20
```

### Finance
```bash
opencli yahoo-finance quote AAPL
opencli barchart options TSLA
```

### Desktop App Control (Electron apps via CDP)
```bash
opencli cursor ask "review this function"
opencli notion search "project ideas"
opencli discord send --channel general "hello"
```

### External CLI Hub (passthrough with auto-install)
```bash
opencli gh pr list --limit 5          # Auto-installs gh if missing
opencli docker ps                      # Auto-installs docker CLI if missing
opencli register mycli                 # Register your own CLI tool
```

### Output Formats
```bash
opencli reddit hot -f json             # JSON (pipe to jq, feed to LLMs)
opencli reddit hot -f yaml             # YAML
opencli reddit hot -f table            # Rich terminal table (default)
opencli reddit hot -f csv              # CSV
opencli reddit hot -f md               # Markdown
```

### API Discovery (auto-generate adapters for new sites)
```bash
opencli explore https://www.example.com --site mysite    # Discover APIs
opencli synthesize mysite                                 # Generate adapter
opencli generate https://www.example.com --goal "hot"     # One-shot
opencli record https://example.com --timeout 120000       # Manual capture
```

## Agent Best Practices

- Always use `-f json` or `-f yaml` for structured output agents can parse
- Run `opencli list -f yaml` at startup to discover all available commands
- Browser commands require Chrome running and logged into the target site
- Public API commands work without Chrome (hackernews, stackoverflow, etc.)
- Use `opencli doctor` to diagnose connectivity issues
- Pipe JSON output through `jq` for filtering: `opencli hackernews top -f json | jq '.[].title'`
- Desktop app commands (cursor, notion) require the app to be running

## Example Workflows

### Research trending topics across platforms
```bash
opencli hackernews top -f json --limit 10 | jq '.[].title'
opencli reddit hot --subreddit artificial -f json --limit 10 | jq '.[].title'
opencli twitter trending -f json --limit 10 | jq '.[].text'
```

### Monitor competitor content
```bash
opencli youtube search "claude code tutorial" -f json --limit 20
opencli tiktok search "ai automation" -f json --limit 20
```
