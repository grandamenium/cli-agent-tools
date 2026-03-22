#!/bin/bash
set -e

echo "Installing Azure CLI (az)..."

if command -v brew &>/dev/null; then
    brew install azure-cli
elif command -v pip3 &>/dev/null; then
    pip3 install azure-cli
else
    echo "Please install Homebrew or pip3. See https://learn.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

echo "Installed: $(az --version 2>&1 | head -1)"
echo "Run 'az login' to authenticate."
