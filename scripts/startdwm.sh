#!/bin/sh

# Kill existing instances
pkill -x picom 2>/dev/null
pkill -x dunst 2>/dev/null
pkill -x dwmblocks 2>/dev/null
pkill -x polkit-gnome-authentication-agent-1 2>/dev/null

# Start polkit agent
if command -v /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 >/dev/null 2>&1; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# Start services
picom &
dunst &
dwmblocks &
udiskie --no-notify --automount &

feh --bg-fill --randomize ~/dwmarch/wallpapers/*

# Start dwm
exec dwm
