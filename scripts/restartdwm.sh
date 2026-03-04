#!/usr/bin/env bash
wal -R
xrdb -merge ~/.Xresources
xrdb -merge ~/.cache/wal/colors.Xresources
xrdb -merge ~/.cache/wal/dwm.Xresources
kill -HUP $(pidof dwm)