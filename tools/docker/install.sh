#!/bin/bash
set -e

echo "Installing Docker..."

if command -v brew &>/dev/null; then
    brew install --cask docker
else
    echo "Please install Homebrew or download Docker Desktop from https://docker.com"
    exit 1
fi

echo "Docker Desktop installed. Open the application to start the Docker daemon."
