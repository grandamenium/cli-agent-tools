#!/bin/bash
set -e

echo "Installing Playwright..."

if command -v npm &>/dev/null; then
    npm install -g playwright
    npx playwright install
else
    echo "Please install Node.js and npm first."
    exit 1
fi

echo "Installed: $(npx playwright --version)"
