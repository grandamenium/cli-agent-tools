#!/bin/bash
set -e

echo "Installing Pandoc..."

if command -v brew &>/dev/null; then
    brew install pandoc
elif command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install pandoc -y
else
    echo "Please install Homebrew or apt-get. See https://pandoc.org/installing.html"
    exit 1
fi

echo "Installed: $(pandoc --version | head -1)"
