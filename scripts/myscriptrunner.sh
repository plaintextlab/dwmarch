#!/usr/bin/env bash

SCRIPT_DIR="$HOME/dwmarch/scripts/myscripts"

script=$(find "$SCRIPT_DIR" -maxdepth 1 -type f -name "*.sh" -printf "%f\n" | fzf)

[ -n "$script" ] && bash "$SCRIPT_DIR/$script"
