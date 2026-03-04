#!/usr/bin/env bash

# Wallpaper picker using fzf + ueberzugpp (X11) + feh
# Dependencies: feh, fzf, ueberzugpp, xdotool

WALLPAPER_DIR="${1:-$HOME/dwmarch/wallpapers}"

if [[ ! -d "$WALLPAPER_DIR" ]]; then
  echo "Error: Directory '$WALLPAPER_DIR' not found."
  exit 1
fi

mapfile -t IMAGES < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \
  \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
     -o -iname "*.webp" -o -iname "*.gif" -o -iname "*.bmp" \) \
  | sort)

if [[ ${#IMAGES[@]} -eq 0 ]]; then
  echo "No images found in '$WALLPAPER_DIR'."
  exit 1
fi

# ── Resolve WINDOWID for ueberzugpp (X11) ────────────────────────────────────

if [[ -z "$WINDOWID" ]]; then
  if command -v xdotool &>/dev/null; then
    export WINDOWID=$(xdotool getactivewindow)
  else
    echo "Error: WINDOWID is not set and xdotool is not installed."
    echo "Install xdotool:  sudo pacman -S xdotool"
    exit 1
  fi
fi

# ── ueberzugpp setup ──────────────────────────────────────────────────────────

FIFO=$(mktemp -u /tmp/ueberzug_fifo_XXXXXX)
mkfifo "$FIFO"

ueberzugpp layer --parser json --silent --output x11 < "$FIFO" &
UEBERZUG_PID=$!

exec 3>"$FIFO"

cleanup() {
  exec 3>&-
  kill "$UEBERZUG_PID" 2>/dev/null
  wait "$UEBERZUG_PID" 2>/dev/null
  rm -f "$FIFO"
}
trap cleanup EXIT INT TERM

show_preview() {
  local img="$1"
  local x="${FZF_PREVIEW_LEFT:-2}"
  local y="${FZF_PREVIEW_TOP:-1}"
  local w="${FZF_PREVIEW_COLUMNS:-60}"
  local h="${FZF_PREVIEW_LINES:-30}"

  printf '{"action":"add","identifier":"preview","x":%d,"y":%d,"width":%d,"height":%d,"scaler":"contain","path":"%s"}\n' \
    "$x" "$y" "$w" "$h" "$img" >&3
}

remove_preview() {
  printf '{"action":"remove","identifier":"preview"}\n' >&3
}

export -f show_preview remove_preview
export FIFO WINDOWID

# ── fzf picker ────────────────────────────────────────────────────────────────

NAMES=()
for img in "${IMAGES[@]}"; do
  NAMES+=("$(basename "$img")")
done

SELECTED=$(
  printf '%s\n' "${NAMES[@]}" | \
  fzf \
    --prompt="🖼  Wallpaper > " \
    --layout=reverse \
    --border=rounded \
    --height=100% \
    --preview="show_preview \"$WALLPAPER_DIR/{}\"" \
    --preview-window="right:60%:wrap" \
    --bind="esc:execute-silent(remove_preview)+abort" \
    --bind="enter:execute-silent(remove_preview)+accept"
)

# ── apply wallpaper ───────────────────────────────────────────────────────────

if [[ -n "$SELECTED" ]]; then
  FULL_PATH="$WALLPAPER_DIR/$SELECTED"
  if [[ -f "$FULL_PATH" ]]; then
    feh --no-fehbg --bg-fill "$FULL_PATH"
    echo "✔ Wallpaper set: $SELECTED"
  else
    echo "Error: Could not resolve '$FULL_PATH'."
    exit 1
  fi
else
  echo "No wallpaper selected."
fi