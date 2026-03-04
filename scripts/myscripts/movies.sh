#!/usr/bin/env bash

find /mnt/2TB_HDD/Movies -type f \( \
-iname "*.mp4" -o \
-iname "*.mkv" -o \
-iname "*.avi" -o \
-iname "*.mov" -o \
-iname "*.webm" -o \
-iname "*.flv" \
\) | fzf --delimiter=/ --with-nth=-1 --bind "enter:become(mpv {})"
