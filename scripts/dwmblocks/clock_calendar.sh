#!/bin/sh

case $BLOCK_BUTTON in
    1) notify-send "Clock" "$(date)" ;;
    3) alacritty -e calcurse ;;
esac

date "+%H:%M"