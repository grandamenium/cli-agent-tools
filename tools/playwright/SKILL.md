---
name: playwright-cli
description: Use Playwright via npx to run browser tests, take screenshots, generate code, and automate browser interactions. Use this instead of the Playwright MCP server.
---

# Playwright CLI (npx playwright)

Browser automation and testing framework. Run tests, capture screenshots, generate test code, and automate web interactions.

- **Official repo:** https://github.com/microsoft/playwright
- **Docs:** https://playwright.dev/docs/intro

## Setup

```bash
npx playwright install              # Install browser binaries
npx playwright install chromium     # Install only Chromium
npx playwright install --with-deps  # Install browsers + system deps
```

## Common Commands

### Running Tests
```bash
npx playwright test                          # Run all tests
npx playwright test tests/login.spec.ts      # Run specific test file
npx playwright test --grep "login"           # Run tests matching pattern
npx playwright test --project=chromium       # Run on specific browser
npx playwright test --headed                 # Run with visible browser
npx playwright test --debug                  # Run in debug mode
npx playwright test --reporter=json          # JSON output for parsing
```

### Code Generation
```bash
npx playwright codegen https://example.com   # Record actions as test code
npx playwright codegen --target javascript   # Generate JS code
```

### Screenshots and PDFs
```bash
npx playwright screenshot https://example.com screenshot.png
npx playwright screenshot --full-page https://example.com full.png
npx playwright pdf https://example.com page.pdf
```

### Trace Viewer
```bash
npx playwright test --trace on              # Record traces
npx playwright show-trace trace.zip         # View trace file
```

### Test Report
```bash
npx playwright show-report                  # Open HTML report
```

## Agent Best Practices

- Use `--reporter=json` for machine-parseable test results
- Use `npx playwright codegen` to generate test scaffolding, then refine
- Always install browsers first with `npx playwright install`
- Use `--project=chromium` to run on a single browser for speed
- Screenshots are useful for visual verification of page state
- Use `--trace on` when debugging flaky tests

## Example Workflows

### Take a screenshot of a page
```bash
npx playwright screenshot --full-page https://example.com /tmp/screenshot.png
```

### Run tests and get JSON results
```bash
npx playwright test --reporter=json 2>/dev/null | jq '.suites[].specs[] | {title, ok}'
```
