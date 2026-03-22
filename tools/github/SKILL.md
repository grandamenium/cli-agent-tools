---
name: github-cli
description: Use the GitHub CLI (gh) to manage repositories, pull requests, issues, actions, and releases directly from the terminal. Use this instead of the GitHub MCP server.
---

# GitHub CLI (gh)

Official CLI for GitHub. Manage repos, PRs, issues, actions, gists, and releases without leaving the terminal.

- **Official repo:** https://github.com/cli/cli
- **Docs:** https://cli.github.com/manual/

## Authentication

```bash
gh auth login            # Interactive login (browser or token)
gh auth status           # Check current auth
gh auth token            # Print current token
```

## Common Commands

### Repositories
```bash
gh repo create my-app --public --clone
gh repo clone owner/repo
gh repo view owner/repo --web
gh repo list owner --limit 20
gh repo fork owner/repo --clone
```

### Pull Requests
```bash
gh pr create --title "Title" --body "Description"
gh pr list --state open
gh pr view 123
gh pr checkout 123
gh pr merge 123 --squash --delete-branch
gh pr review 123 --approve
gh pr diff 123
gh pr checks 123
```

### Issues
```bash
gh issue create --title "Bug" --body "Details" --label bug
gh issue list --state open --assignee @me
gh issue view 456
gh issue close 456
gh issue comment 456 --body "Fixed in #123"
```

### Actions / Workflows
```bash
gh run list --limit 10
gh run view 789
gh run watch 789
gh run rerun 789
gh workflow list
gh workflow run deploy.yml --ref main
```

### Releases
```bash
gh release create v1.0.0 --title "v1.0.0" --notes "Release notes"
gh release list
gh release download v1.0.0
```

### API (raw access)
```bash
gh api repos/owner/repo/pulls/123/comments
gh api graphql -f query='{ viewer { login } }'
gh api repos/owner/repo --jq '.stargazers_count'
```

## Agent Best Practices

- Always use `--json` flag with `--jq` for structured output: `gh pr list --json number,title --jq '.[].title'`
- Use `gh api` for anything not covered by built-in commands
- Pass PR/issue bodies via heredoc for multi-line content
- Use `--repo owner/repo` flag when working outside the repo directory
- Check `gh auth status` before operations to confirm authentication
- Prefer `gh pr create --body "$(cat <<'EOF' ... EOF)"` for formatted bodies

## Example Workflows

### Create PR with full context
```bash
gh pr create --title "Add user auth" --body "$(cat <<'EOF'
## Summary
- Added JWT authentication middleware
- Created login/register endpoints

## Test Plan
- [x] Unit tests pass
- [ ] Manual testing needed
EOF
)"
```

### Get CI status for current branch
```bash
gh pr checks --json name,state --jq '.[] | "\(.name): \(.state)"'
```
