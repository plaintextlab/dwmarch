#!/bin/sh

OUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

VOL=$(printf "%s" "$OUT" | awk '{print int($2*100)}')
MUTE=$(printf "%s" "$OUT" | grep -o MUTED)

if [ -n "$MUTE" ]; then
    printf "󰝟 Mute\n"
else
    printf "󰕾 %s%%\n" "$VOL"
fi