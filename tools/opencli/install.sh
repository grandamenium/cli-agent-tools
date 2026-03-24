#!/bin/bash
set -e

echo "Installing OpenCLI..."

if command -v npm &>/dev/null; then
    npm install -g @jackwener/opencli
elif command -v yarn &>/dev/null; then
    yarn global add @jackwener/opencli
else
    echo "Node.js and npm are required. Install from https://nodejs.org"
    exit 1
fi

echo "Installed: $(opencli --version)"
echo ""
echo "Next steps:"
echo "  1. Load the Chrome extension for browser commands:"
echo "     - Clone https://github.com/jackwener/opencli"
echo "     - Open chrome://extensions > Developer mode > Load unpacked > select extension/ folder"
echo "  2. Run 'opencli doctor' to verify setup"
echo "  3. Run 'opencli list' to see all available commands"
