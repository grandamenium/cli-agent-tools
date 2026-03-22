#!/bin/bash
set -e

echo "Installing Vercel CLI..."

if command -v npm &>/dev/null; then
    npm install -g vercel
else
    echo "Please install Node.js and npm first."
    exit 1
fi

echo "Installed: $(vercel --version)"
echo "Run 'vercel login' to authenticate."
