#!/bin/zsh

if [[ -z "$1" ]]; then
    wallpaper="$HOME/Pictures/wallpapers"
elif [[ -f "$1" ]]; then
    wallpaper="$1"
else
    wallpaper="$(fd "$1" "$HOME/Pictures/wallpapers/" | shuf -n 1)"
fi

wal -i "$wallpaper"
wallpaper="$(cat "$HOME/.cache/wal/wal")"

# hyprpaper
if [[ -z "$(pgrep hyprpaper)" ]]; then
    hyprctl --instance 0 dispatch exec hyprpaper
fi
# echo -e "preload = $wallpaper\nwallpaper = , $wallpaper" | tr -d '"' | cat >"$HOME/.config/hypr/hyprpaper.conf"
hyprctl --instance 0 hyprpaper reload ",$(echo "$wallpaper" | tr -d '"')" >/dev/null

# create waybar style.css from template
waybar_stylesheet="$HOME/.config/waybar/style.css"
template="$HOME/.config/waybar/template-style.css"
wal_vars="$HOME/.cache/wal/colors"
cat "$template" >"$waybar_stylesheet"
index=0
for color in $(cat "$wal_vars"); do
    sed "s/var(--color$index)/$color/" <<<"$(cat "$waybar_stylesheet")" >"$waybar_stylesheet"
    ((index += 1))
done
[[ -n "$(pgrep waybar)" ]] && killall -SIGUSR2 waybar &>/dev/null # refresh waybar config

echo "Wallpaper set: $(basename $wallpaper)"
