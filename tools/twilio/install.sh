#!/bin/bash
set -e

echo "Installing Twilio CLI..."

if command -v brew &>/dev/null; then
    brew tap twilio/brew && brew install twilio
elif command -v npm &>/dev/null; then
    npm install -g twilio-cli
else
    echo "Please install Homebrew or npm. See https://www.twilio.com/docs/twilio-cli"
    exit 1
fi

echo "Installed: $(twilio --version)"
echo "Run 'twilio login' to authenticate."
