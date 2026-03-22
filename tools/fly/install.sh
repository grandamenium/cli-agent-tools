#!/bin/bash
set -e

echo "Installing Fly.io CLI (flyctl)..."

if command -v brew &>/dev/null; then
    brew install flyctl
else
    curl -L https://fly.io/install.sh | sh
fi

echo "Installed: $(fly version)"
echo "Run 'fly auth login' to authenticate."
