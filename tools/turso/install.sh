#!/bin/bash
set -e

echo "Installing Turso CLI..."

if command -v brew &>/dev/null; then
    brew install tursodatabase/tap/turso
else
    curl -sSfL https://get.tur.so/install.sh | bash
fi

echo "Installed: $(turso --version)"
echo "Run 'turso auth login' to authenticate."
