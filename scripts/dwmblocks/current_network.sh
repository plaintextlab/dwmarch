#!/bin/sh

SSID=$(nmcli -t -f active,ssid dev wifi | awk -F: '$1=="yes"{print $2}')

if [ -n "$SSID" ]; then
    printf "  %s\n" "$SSID"
else
    printf " Offline\n"
fi