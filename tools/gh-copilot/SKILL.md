---
name: gh-copilot-cli
description: Use GitHub Copilot in the CLI to get AI-suggested shell commands, explain commands, and translate natural language to terminal commands via the gh copilot extension.
---

# GitHub Copilot CLI (gh copilot)

AI-powered terminal assistant. Translate natural language to shell commands, explain commands, and get suggestions.

- **Official docs:** https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line

## Prerequisites

Requires an active GitHub Copilot subscription and the gh CLI.

## Setup

```bash
gh extension install github/gh-copilot     # Install the extension
gh copilot --version                        # Verify installation
```

## Common Commands

### Suggest Commands
```bash
gh copilot suggest "find all large files over 100MB"
gh copilot suggest "compress all PNG files in this directory"
gh copilot suggest "create a git branch from a specific commit"
gh copilot suggest "find and kill process on port 3000"
gh copilot suggest "set up a cron job to run daily at 9am"
```

### Explain Commands
```bash
gh copilot explain "tar -xzf archive.tar.gz"
gh copilot explain "find . -name '*.log' -mtime +30 -delete"
gh copilot explain "awk '{print $2}' file.txt | sort | uniq -c"
gh copilot explain "ssh -L 8080:localhost:80 user@server"
```

### Shell Aliases (for convenience)
```bash
# Add to ~/.zshrc or ~/.bashrc:
# alias suggest='gh copilot suggest'
# alias explain='gh copilot explain'
```

## Agent Best Practices

- Use `suggest` to generate complex shell commands from natural language descriptions
- Use `explain` to understand unfamiliar commands before running them
- The tool supports git, shell, and gh-specific command suggestions
- Suggestions are context-aware (considers current directory, OS, shell)
- Always review suggested commands before executing - they may need adjustment
- Use this for command discovery, not as a replacement for known commands

## Example Workflows

### Find the right command for a task
```bash
gh copilot suggest "recursively find all TypeScript files modified in the last week"
# Copilot suggests: find . -name "*.ts" -mtime -7
```

### Understand a complex pipeline
```bash
gh copilot explain "git log --oneline --graph --all --decorate"
```
