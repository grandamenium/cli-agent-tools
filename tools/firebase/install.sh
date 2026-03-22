#!/bin/bash
set -e

echo "Installing Firebase CLI..."

if command -v npm &>/dev/null; then
    npm install -g firebase-tools
else
    echo "Please install Node.js and npm first."
    exit 1
fi

echo "Installed: $(firebase --version)"
echo "Run 'firebase login' to authenticate."
