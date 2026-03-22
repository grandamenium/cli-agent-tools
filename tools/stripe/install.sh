#!/bin/bash
set -e

echo "Installing Stripe CLI..."

if command -v brew &>/dev/null; then
    brew install stripe-cli
else
    echo "Please install Homebrew. See https://docs.stripe.com/stripe-cli/install"
    exit 1
fi

echo "Installed: $(stripe --version)"
echo "Run 'stripe login' to authenticate."
