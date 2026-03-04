#!/usr/bin/env bash
xrdb -merge ~/.Xresources
kill -HUP $(pidof dwm)