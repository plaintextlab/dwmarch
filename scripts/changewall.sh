wal -i ~/dwmarch/wallpapers/

source ~/.cache/wal/colors.sh

cat > ~/.cache/wal/dwm.Xresources <<EOF
dwm.normbgcolor: $color0
dwm.normbordercolor: $color8
dwm.normfgcolor: $color7
dwm.selbgcolor: $color4
dwm.selbordercolor: $color4
dwm.selfgcolor: $color0
EOF

#xrdb -merge ~/.cache/wal/colors.Xresources
#xrdb -merge ~/.cache/wal/dwm.Xresources
#kill -HUP $(pidof dwm)


~/dwmarch/scripts/starship_colors.sh

~/dwmarch/scripts/vscode_colors.sh



~/dwmarch/scripts/restartdwm.sh
