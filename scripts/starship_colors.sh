source ~/.cache/wal/colors.sh

# Starship colors
cat > ~/.config/starship/starship-wal.toml <<EOF
[palettes.wal]
color_fg0 = "$foreground"
color_bg1 = "$background"
color_bg3 = "$color8"
color_blue = "$color4"
color_aqua = "$color6"
color_green = "$color2"
color_orange = "$color3"
color_purple = "$color5"
color_red = "$color1"
color_yellow = "$color3"
EOF


#!/usr/bin/env bash

INPUT="/home/bita/.config/starship/starship.toml"
REPLACE="/home/bita/.config/starship/starship-wal.toml"
OUTPUT="/home/bita/.config/starship.toml"

awk -v repl="$REPLACE" '
BEGIN {
    while ((getline line < repl) > 0) {
        replacement = replacement line "\n"
    }
}
{
    if ($0 ~ /^\[palettes\.wal\]/) {
        print replacement
        skip=1
        next
    }

    if (skip && $0 ~ /^\[/ && $0 !~ /^\[palettes\.wal\]/) {
        skip=0
    }

    if (!skip) {
        print
    }
}
' "$INPUT" > "$OUTPUT"