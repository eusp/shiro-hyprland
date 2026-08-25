#!/bin/bash

source="$HOME/.config/hypr/conf/colors.conf"
mode_file="$HOME/.config/shiro-theme/wallpaper-mode"

backgroundmp4=$(grep -oP '^\$backgroundmp4\s*=\s*\K.*' "$source")
background=$(grep -oP '^\$background\s*=\s*\K.*' "$source")

mode="animated"
if [ -f "$mode_file" ]; then
    mode=$(tr -d '[:space:]' < "$mode_file")
fi

pkill mpvpaper
pkill hyprpaper

sleep 0.5

if [ "$mode" = "static" ] || [ ! -f "$backgroundmp4" ]; then
    hyprpaper &
    sleep 0.5
    hyprctl hyprpaper preload "$background"
    hyprctl hyprpaper wallpaper ",$background"
else
    mpvpaper -o "no-audio loop --panscan=0.65 --video-align-y=1" "*" "$backgroundmp4" &
fi
