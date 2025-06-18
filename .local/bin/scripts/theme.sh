#!/bin/bash

if [[ -z "$1" ]]; then
    # if fd -q "$1" ~/Pictures/wallpapers/; then
    wallpaper=~/Pictures/wallpapers
elif [[ -f "$1" ]]; then
    wallpaper="$1"
else
    wallpaper="$(fd "$1" ~/Pictures/wallpapers/ | shuf -n 1)"
fi

wal -i "$wallpaper"
wallpaper="$(cat ~/.cache/wal/wal)"

# hyprpaper
echo -e "preload = $wallpaper\nwallpaper = , $wallpaper" | tr -d '"' | cat >~/.config/hypr/hyprpaper.conf
hyprctl --instance 0 hyprpaper reload ",$(echo "$wallpaper" | tr -d '"')" >/dev/null

# create waybar style.css from template
waybar_stylesheet=~/.config/waybar/style.css
template=~/.config/waybar/template-style.css
wal_vars=~/.cache/wal/colors
cat "$template" >"$waybar_stylesheet"
index=0
while read -r color; do
    sed -i "s/var(--color$index)/$color/" "$waybar_stylesheet"
    ((index += 1))
done <"$wal_vars"
[[ -n "$(pgrep waybar)" ]] && killall -SIGUSR2 waybar &>/dev/null # refresh waybar config
