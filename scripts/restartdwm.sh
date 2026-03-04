#!/usr/bin/env bash
xrdb -merge ~/.Xresources
wal -R
xrdb -merge ~/.cache/wal/colors.Xresources
kill -HUP $(pidof dwm)