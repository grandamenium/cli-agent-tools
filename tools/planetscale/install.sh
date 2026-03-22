#!/bin/bash
set -e

echo "Installing PlanetScale CLI (pscale)..."

if command -v brew &>/dev/null; then
    brew install planetscale/tap/pscale
else
    echo "Please install Homebrew. See https://github.com/planetscale/cli"
    exit 1
fi

echo "Installed: $(pscale version)"
echo "Run 'pscale auth login' to authenticate."
