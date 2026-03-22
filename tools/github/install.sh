#!/bin/bash
set -e

echo "Installing GitHub CLI (gh)..."

if command -v brew &>/dev/null; then
    brew install gh
elif command -v apt-get &>/dev/null; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt-get update && sudo apt-get install gh -y
else
    echo "Please install Homebrew or use apt-get. See https://cli.github.com"
    exit 1
fi

echo "Installed: $(gh --version)"
echo "Run 'gh auth login' to authenticate."
