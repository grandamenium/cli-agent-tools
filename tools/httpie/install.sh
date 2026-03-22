#!/bin/bash
set -e

echo "Installing HTTPie..."

if command -v brew &>/dev/null; then
    brew install httpie
elif command -v pip3 &>/dev/null; then
    pip3 install httpie
else
    echo "Please install Homebrew or pip3. See https://httpie.io/docs/cli/installation"
    exit 1
fi

echo "Installed: $(http --version)"
