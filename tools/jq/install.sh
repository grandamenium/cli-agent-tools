#!/bin/bash
set -e

echo "Installing jq..."

if command -v brew &>/dev/null; then
    brew install jq
elif command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install jq -y
else
    echo "Please install Homebrew or apt-get. See https://jqlang.github.io/jq/download/"
    exit 1
fi

echo "Installed: $(jq --version)"
