#!/bin/bash
set -e

echo "Installing kubectl..."

if command -v brew &>/dev/null; then
    brew install kubectl
else
    echo "Please install Homebrew. See https://kubernetes.io/docs/tasks/tools/"
    exit 1
fi

echo "Installed: $(kubectl version --client --short 2>/dev/null || kubectl version --client)"
