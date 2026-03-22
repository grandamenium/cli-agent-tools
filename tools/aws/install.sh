#!/bin/bash
set -e

echo "Installing AWS CLI..."

if command -v brew &>/dev/null; then
    brew install awscli
elif command -v pip3 &>/dev/null; then
    pip3 install awscli
else
    echo "Please install Homebrew or pip3. See https://docs.aws.amazon.com/cli/"
    exit 1
fi

echo "Installed: $(aws --version)"
echo "Run 'aws configure' to set up credentials."
