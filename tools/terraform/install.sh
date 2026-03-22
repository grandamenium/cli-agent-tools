#!/bin/bash
set -e

echo "Installing Terraform..."

if command -v brew &>/dev/null; then
    brew install terraform
else
    echo "Please install Homebrew. See https://developer.hashicorp.com/terraform/install"
    exit 1
fi

echo "Installed: $(terraform --version | head -1)"
