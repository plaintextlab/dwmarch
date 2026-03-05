#!/bin/sh

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=dwm

# Kill existing instances
pkill -x picom 2>/dev/null
pkill -x dunst 2>/dev/null
pkill -x dwmblocks 2>/dev/null
pkill -x polkit-gnome-authentication-agent-1 2>/dev/null
pkill -x xdg-desktop-portal 2>/dev/null
pkill -x xdg-desktop-portal-gtk 2>/dev/null

# Start polkit agent
if command -v /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 >/dev/null 2>&1; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# Start portal
/usr/lib/xdg-desktop-portal &
/usr/lib/xdg-desktop-portal-gtk &

# Start services
picom &
dunst &
dwmblocks &
udiskie --tray &
greenclip daemon &

wal -R
xrdb -merge ~/.Xresources
xrdb -merge ~/.cache/wal/colors.Xresources
xrdb -merge ~/.cache/wal/dwm.Xresources

# Start dwm
exec dwm
