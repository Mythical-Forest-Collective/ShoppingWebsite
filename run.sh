#!/bin/bash

# Set up choosenim
if [[ ! -f "/tmp/choosenim" ]]; then
  # Curl seems to be included in blank repls
  curl -sL "https://github.com/dom96/choosenim/releases/download/v0.8.4/choosenim-0.8.4_linux_amd64" > /tmp/choosenim
  chmod +x /tmp/choosenim
fi

export PATH="$HOME/.nimble/bin:$PATH"

# Setting up the Nim installation
if [[ ! -f "$HOME/.nimble/bin/nim" ]]; then
  /tmp/choosenim stable -y
fi

# Declare dependencies
declare -A deps

# deps["Local package name"]="Nimble package name"
deps["prologue"]="prologue"

# Check for dependencies and install them if not present
PKGLIST=$(nimble list -i)

for dep in "${!deps[@]}"; do
  pkg=${deps[$dep]}

  if ! echo $PKGLIST | grep -q $pkg; then
    nimble --accept install "$pkg"
  fi
done

# Run the nim program
nim c --run main.nim