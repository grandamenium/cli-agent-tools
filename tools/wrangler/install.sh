#!/bin/bash
set -e

echo "Installing Wrangler (Cloudflare Workers CLI)..."

if command -v npm &>/dev/null; then
    npm install -g wrangler
else
    echo "Please install Node.js and npm first."
    exit 1
fi

echo "Installed: $(npx wrangler --version)"
echo "Run 'npx wrangler login' to authenticate."
