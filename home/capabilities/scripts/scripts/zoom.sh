#!/usr/bin/env bash

zoom=$(hyprctl getoption misc:cursor_zoom_factor | awk 'FNR == 3 {print $2}')
zoom_factor=$(echo "val=$zoom; val+=$1; val" | bc)

if [ $(bc <<< "$zoom_factor >= 1") -eq 1 ]; then
  hyprctl keyword misc:cursor_zoom_factor $zoom_factor &> /dev/null
fi
