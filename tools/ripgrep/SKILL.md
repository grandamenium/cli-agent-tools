---
name: ripgrep-cli
description: Use ripgrep (rg) for extremely fast recursive regex search across codebases. Respects .gitignore, supports file type filtering, and produces structured output.
---

# ripgrep (rg)

Blazing fast line-oriented search tool. Recursively searches directories with regex, respecting .gitignore.

- **Official repo:** https://github.com/BurntSushi/ripgrep
- **Docs:** https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md

## Common Commands

### Basic Search
```bash
rg "pattern"                               # Search current dir recursively
rg "pattern" src/                          # Search specific directory
rg "pattern" file.txt                      # Search specific file
rg -i "pattern"                            # Case insensitive
rg -w "word"                               # Whole word match
rg -F "literal string"                     # Fixed string (no regex)
```

### Regex
```bash
rg "fn\s+\w+"                              # Functions in Rust
rg "import .* from"                        # ES module imports
rg "TODO|FIXME|HACK"                       # Multiple patterns
rg "error" --multiline                     # Multi-line patterns
```

### File Type Filtering
```bash
rg "pattern" -t py                         # Only Python files
rg "pattern" -t js -t ts                   # JS and TS files
rg "pattern" -T test                       # Exclude test files
rg "pattern" -g "*.json"                   # Glob pattern
rg "pattern" -g "!node_modules"            # Exclude directory
rg --type-list                             # Show all file types
```

### Context
```bash
rg "pattern" -C 3                          # 3 lines before and after
rg "pattern" -B 2                          # 2 lines before
rg "pattern" -A 5                          # 5 lines after
```

### Output Control
```bash
rg "pattern" -l                            # Files with matches only
rg "pattern" -c                            # Count matches per file
rg "pattern" --json                        # JSON output
rg "pattern" -n                            # Line numbers (default)
rg "pattern" -o                            # Only matching text
rg "pattern" --stats                       # Show statistics
```

### Replacement
```bash
rg "old" -r "new"                          # Show replacements (preview)
rg "(\w+)@(\w+)" -r '$2/$1'               # Regex capture groups
```

### Advanced
```bash
rg "pattern" --hidden                      # Include hidden files
rg "pattern" --no-ignore                   # Don't respect .gitignore
rg "pattern" -z                            # Search compressed files
rg "pattern" --sort modified               # Sort by modification time
rg "pattern" -m 5                          # Max 5 matches per file
```

## Agent Best Practices

- Use `--json` for machine-parseable output
- Use `-l` (files only) when you need file paths, not content
- Use `-t` for file types instead of glob patterns when possible
- Use `-F` for literal strings to avoid regex escaping issues
- Use `--stats` to understand search scope and match counts
- Combine `-c` (count) with `--sort-files` for finding files with most matches
- rg respects .gitignore by default - use `--no-ignore` to override

## Example Workflows

### Find all TODO comments in source code
```bash
rg "TODO|FIXME" -t py -t js -t ts --stats
```

### Find files containing a function definition
```bash
rg "def process_payment" -l
```
