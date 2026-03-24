---
name: opencli
description: Universal CLI hub that turns any website, Electron app, or local tool into a command-line interface. Reuses Chrome login sessions for zero-credential browser automation. 50+ pre-built adapters for social media, news, finance, and developer tools. AI-agent ready with structured output.
---

# OpenCLI

Universal CLI framework that makes any website, Electron app, or local binary scriptable from the terminal. Reuses your Chrome login sessions so there are no API keys or credentials to manage.

- **Official repo:** https://github.com/jackwener/opencli
- **NPM:** https://www.npmjs.com/package/@jackwener/opencli
- **Docs:** https://github.com/jackwener/opencli/blob/main/README.md

## Setup

```bash
# Install
npm install -g @jackwener/opencli

# Chrome extension (one-time, required for browser commands)
# 1. Download from GitHub Releases or clone repo
# 2. chrome://extensions > Developer mode > Load unpacked > select extension/ folder

# Verify
opencli doctor
opencli list
```

## Core Commands

### Discovery
```bash
opencli list                    # All 50+ available commands
opencli list -f yaml            # Structured registry (for AI agents)
opencli doctor                  # Diagnose daemon + extension status
```

### Social & Content Platforms (browser, uses Chrome login)
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
opencli v2ex hot --limit 20
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

### Desktop App Control (CDP, Electron apps)
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

## Output Formats

All commands support structured output:
```bash
opencli reddit hot -f json             # JSON (pipe to jq, feed to LLMs)
opencli reddit hot -f yaml             # YAML
opencli reddit hot -f table            # Rich terminal table (default)
opencli reddit hot -f csv              # CSV
opencli reddit hot -f md               # Markdown
```

## Building Custom Adapters

### YAML adapter (recommended for data fetching)
```yaml
site: mysite
name: trending
domain: www.mysite.com
strategy: cookie
browser: true
args:
  limit: { type: int, default: 20 }
pipeline:
  - navigate: https://www.mysite.com
  - evaluate: |
      (async () => {
        const res = await fetch('/api/trending', {credentials: 'include'});
        return (await res.json()).items;
      })()
  - map: { rank: ${{ index + 1 }}, title: ${{ item.title }} }
  - limit: ${{ args.limit }}
columns: [rank, title]
```

### API discovery (auto-generate adapters)
```bash
opencli explore https://www.example.com --site mysite    # Discover APIs
opencli synthesize mysite                                 # Generate YAML adapter
opencli generate https://www.example.com --goal "hot"     # One-shot: explore + synthesize
opencli record https://example.com --timeout 120000       # Manual API capture
```

## Agent Best Practices

- Always use `-f json` or `-f yaml` for structured output agents can parse
- Run `opencli list -f yaml` at startup to discover all available commands
- Browser commands require Chrome running and logged into the target site
- Public API commands work without Chrome (hackernews, v2ex, stackoverflow, etc.)
- Use `opencli doctor` to diagnose connectivity issues
- Pipe JSON output through `jq` for filtering: `opencli hackernews top -f json | jq '.[].title'`
- Desktop app commands (cursor, notion) require the app to be running

## Architecture

- **CLI Layer:** npm global binary, Commander.js, routes to adapters
- **Browser Bridge:** Auto-spawning daemon on localhost:19825, Chrome Extension for session reuse
- **Adapters:** YAML (declarative) or TypeScript (programmatic), auto-discovered at startup
- **CDP:** Direct Chrome DevTools Protocol for Electron app control
- **Zero LLM cost:** All execution is deterministic, no API calls to LLM providers

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

### Automate desktop workflows
```bash
opencli cursor ask "what does the main function do?"
opencli notion search "meeting notes" -f json | jq '.[0].url'
```
