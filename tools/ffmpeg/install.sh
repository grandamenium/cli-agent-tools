#!/bin/bash
set -e

echo "Installing FFmpeg..."

if command -v brew &>/dev/null; then
    brew install ffmpeg
elif command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install ffmpeg -y
else
    echo "Please install Homebrew or apt-get. See https://ffmpeg.org/download.html"
    exit 1
fi

echo "Installed: $(ffmpeg -version 2>&1 | head -1)"
