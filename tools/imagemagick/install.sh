#!/bin/bash
set -e

echo "Installing ImageMagick..."

if command -v brew &>/dev/null; then
    brew install imagemagick
elif command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install imagemagick -y
else
    echo "Please install Homebrew or apt-get. See https://imagemagick.org/script/download.php"
    exit 1
fi

echo "Installed: $(magick --version 2>&1 | head -1)"
