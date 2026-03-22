#!/bin/bash
set -e

echo "Installing ripgrep (rg)..."

if command -v brew &>/dev/null; then
    brew install ripgrep
elif command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install ripgrep -y
elif command -v cargo &>/dev/null; then
    cargo install ripgrep
else
    echo "Please install Homebrew, apt-get, or cargo. See https://github.com/BurntSushi/ripgrep#installation"
    exit 1
fi

echo "Installed: $(rg --version | head -1)"
