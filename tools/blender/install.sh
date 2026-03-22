#!/bin/bash
set -e

echo "Installing Blender..."

if command -v brew &>/dev/null; then
    brew install --cask blender
else
    echo "Please install Homebrew or download from https://www.blender.org/download/"
    exit 1
fi

echo "Blender installed. Run 'blender --version' to verify."
