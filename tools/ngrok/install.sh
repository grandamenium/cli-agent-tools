#!/bin/bash
set -e

echo "Installing ngrok..."

if command -v brew &>/dev/null; then
    brew install ngrok
else
    echo "Please install Homebrew. See https://ngrok.com/download"
    exit 1
fi

echo "Installed: $(ngrok version)"
echo "Run 'ngrok config add-authtoken YOUR_TOKEN' to authenticate."
