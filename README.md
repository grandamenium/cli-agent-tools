# CLI Agent Tools

30+ CLI tools with ready-to-use Claude Code skills for AI agents. Replace bloated MCP servers with efficient CLI alternatives.

## Why CLI over MCP?

AI models have been trained on billions of terminal interactions. They already know CLI tools. MCP servers add unnecessary overhead:

- **10-32x cheaper** - CLI tools use a fraction of the tokens ([Scalekit benchmark](https://www.scalekit.com/blog/mcp-vs-cli-use))
- **72% context waste** - MCP servers dump entire schemas into your context window before you ask a single question
- **100% vs 72% reliability** - CLI commands succeed reliably; MCP servers have a 28% failure rate

A typical MCP server (like GitHub's) ships 93 tools costing ~55,000 tokens just to initialize. The equivalent `gh` CLI skill? ~800 tokens.

## What's Included

30 tools across 8 categories, each with a `SKILL.md` (Claude Code skill) and `install.sh`:

| Category | Tools |
|----------|-------|
| **Cloud** | aws, gcloud, az |
| **DevOps** | gh, docker, kubectl, terraform |
| **Deployment** | vercel, railway, netlify, fly, firebase, wrangler |
| **Database** | supabase, turso, planetscale |
| **Media** | ffmpeg, imagemagick, blender, yt-dlp |
| **Communication** | stripe, resend, twilio |
| **Testing** | playwright, httpie |
| **Utility** | jq, ripgrep, ngrok, pandoc, gh-copilot |

## Quick Start

### Use a single skill

Copy any `SKILL.md` into your project's `.claude/skills/` directory:

```bash
# Example: Add the GitHub CLI skill
mkdir -p .claude/skills
cp tools/github/SKILL.md .claude/skills/github.md
```

Claude Code will automatically pick up the skill and use `gh` instead of the GitHub MCP server.

### Install a tool

```bash
# Install a specific tool
./install-all.sh --tool github

# Install a category
./install-all.sh --category cloud    # Installs aws, gcloud, az

# Install everything
./install-all.sh --all

# See what's available
./install-all.sh --list
```

### Install all skills at once

```bash
# Copy all skills to your project
for dir in tools/*/; do
  tool=$(basename "$dir")
  cp "$dir/SKILL.md" ".claude/skills/${tool}.md"
done
```

### Install globally (all projects)

```bash
# Copy skills to your global Claude Code config
mkdir -p ~/.claude/skills
for dir in tools/*/; do
  tool=$(basename "$dir")
  cp "$dir/SKILL.md" "$HOME/.claude/skills/${tool}.md"
done
```

## Skill Format

Each `SKILL.md` follows a consistent structure:

```markdown
---
name: tool-name
description: What the tool does and when to use it
---

# Tool Name

## Authentication (if applicable)
## Common Commands
## Agent Best Practices
## Example Workflows
```

Skills use YAML frontmatter so Claude Code can index and discover them automatically.

## Registry

The `registry.json` file contains metadata for all 30 tools including:
- Install commands (brew, npm, pip)
- Official documentation URLs
- Source repositories
- Categories

## Contributing

To add a new tool:

1. Create `tools/<tool-name>/SKILL.md` with YAML frontmatter
2. Create `tools/<tool-name>/install.sh`
3. Add the tool to `registry.json`
4. Submit a PR

## License

MIT
