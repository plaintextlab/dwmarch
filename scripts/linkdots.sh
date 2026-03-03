#!/usr/bin/env bash

set -euo pipefail

# Resolve script directory
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

DOTS_DIR="$BASE_DIR/dots"
CONFIG_DIR="$HOME/.config"

mkdir -p "$CONFIG_DIR"

for dir in "$DOTS_DIR"/*/; do
    name="$(basename "$dir")"
    target="$CONFIG_DIR/$name"

    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -rf "$target"
    fi

    ln -s "$dir" "$target"
    echo "Linked $name → $target"
done
