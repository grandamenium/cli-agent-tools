#!/bin/bash
set -e

echo "Installing GitHub Copilot CLI extension..."

if ! command -v gh &>/dev/null; then
    echo "GitHub CLI (gh) is required. Install it first: brew install gh"
    exit 1
fi

gh extension install github/gh-copilot

echo "Installed. Requires an active GitHub Copilot subscription."
echo "Run 'gh copilot suggest \"your request\"' to get started."
