#!/bin/bash
set -e

echo "Installing Resend CLI..."

if command -v brew &>/dev/null; then
    brew install resend/cli/resend
elif command -v npm &>/dev/null; then
    npm install -g resend-cli
else
    echo "Please install Homebrew or npm. See https://resend.com/docs/cli"
    exit 1
fi

echo "Installed: $(resend --version)"
echo "Run 'resend login' to authenticate."
