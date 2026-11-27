#!/bin/bash

source="$HOME/.config/hypr/conf/colors.lua"
mode_file="$HOME/.config/shiro-theme/wallpaper-mode"

backgroundmp4=$(grep -oP 'backgroundmp4\s*=\s*"\K[^"]*' "$source")
background=$(grep -oP '(?<!mp4)\bbackground\s*=\s*"\K[^"]*' "$source")

mode="animated"
if [ -f "$mode_file" ]; then
    mode=$(tr -d '[:space:]' < "$mode_file")
fi

pkill mpvpaper
pkill hyprpaper

sleep 0.5

if [ "$mode" = "static" ] || [ ! -f "$backgroundmp4" ]; then
    # Reuse Hyprland's Lua setting when launching Hyprpaper.
    splash=true
    if grep -Eq '^[[:space:]]*disable_splash_rendering[[:space:]]*=[[:space:]]*true[[:space:]]*,' "$HOME/.config/hypr/conf/decorations.lua"; then
        splash=false
    fi
    runtime_config="${XDG_RUNTIME_DIR:?}/hypr/$HYPRLAND_INSTANCE_SIGNATURE/hyprpaper-config"
    printf 'splash = %s\n' "$splash" > "$runtime_config" || exit 1
    hyprpaper -c "$runtime_config" &
    sleep 0.5
    hyprctl hyprpaper wallpaper ",$background"
else
    mpvpaper -o "no-audio loop --panscan=0.65 --video-align-y=1" "*" "$backgroundmp4" &
fi
