#!/bin/bash
set -e

echo "Installing Supabase CLI..."

if command -v brew &>/dev/null; then
    brew install supabase/tap/supabase
elif command -v npm &>/dev/null; then
    npm install -g supabase
else
    echo "Please install Homebrew or npm. See https://supabase.com/docs/reference/cli"
    exit 1
fi

echo "Installed: $(supabase --version)"
echo "Run 'supabase login' to authenticate."
