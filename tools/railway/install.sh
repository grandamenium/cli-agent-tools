#!/bin/bash
set -e

echo "Installing Railway CLI..."

if command -v brew &>/dev/null; then
    brew install railway
elif command -v npm &>/dev/null; then
    npm install -g @railway/cli
else
    echo "Please install Homebrew or npm. See https://docs.railway.app/reference/cli-api"
    exit 1
fi

echo "Installed: $(railway --version)"
echo "Run 'railway login' to authenticate."
