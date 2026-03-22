#!/bin/bash
set -e

echo "Installing Google Cloud CLI (gcloud)..."

if command -v brew &>/dev/null; then
    brew install --cask google-cloud-sdk
else
    echo "Please install Homebrew. See https://cloud.google.com/sdk/docs/install"
    exit 1
fi

echo "Installed: $(gcloud --version 2>&1 | head -1)"
echo "Run 'gcloud auth login' to authenticate."
