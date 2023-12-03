#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.wallpapers"
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=2

# Randomly choose a wallpaper from the directory
wallpaper=$(ls $WALLPAPER_DIR | sort -R | tail -1)
swww img $WALLPAPER_DIR/$wallpaper --transition-type grow --transition-pos 0.854,0.977 --transition-step 90 --transition-duration 2
