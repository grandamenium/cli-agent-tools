#!/bin/bash
set -e

echo "Installing yt-dlp..."

if command -v brew &>/dev/null; then
    brew install yt-dlp
elif command -v pip3 &>/dev/null; then
    pip3 install yt-dlp
else
    echo "Please install Homebrew or pip3. See https://github.com/yt-dlp/yt-dlp#installation"
    exit 1
fi

echo "Installed: $(yt-dlp --version)"
