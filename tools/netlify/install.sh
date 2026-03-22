#!/bin/bash
set -e

echo "Installing Netlify CLI..."

if command -v npm &>/dev/null; then
    npm install -g netlify-cli
else
    echo "Please install Node.js and npm first."
    exit 1
fi

echo "Installed: $(netlify --version)"
echo "Run 'netlify login' to authenticate."
