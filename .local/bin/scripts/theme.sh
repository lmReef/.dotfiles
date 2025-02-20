# TODO: implement -i with fzf
if [[ -z $1 || -z $(ls "$HOME"/Pictures/wallpapers/ | grep "$1") ]]; then
    wallpaper=$HOME/Pictures/wallpapers/
else
    wallpaper="$(ls "$HOME"/Pictures/wallpapers/ | grep "$1" | shuf -n 1)"
fi

echo "$wallpaper"

if [[ -n $(echo "$wallpaper" | grep "/") ]]; then
    wal -i "$wallpaper" >/dev/null
else
    wal -i "$HOME/Pictures/wallpapers/$wallpaper" >/dev/null
fi
wallpaper=$(jq .wallpaper "$HOME"/.cache/wal/colors.json)

# copy of the current wallpaper for lockscreen to use
# TODO: figure out how to reference the active wallpaper correctly without copying. ln?
if [[ -f $HOME/.config/hypr/current_wallpaper.* ]]; then
    rm "$HOME"/.config/hypr/current_wallpaper.*
fi
cp -lf "$(echo "$wallpaper" | tr -d '"')" "$HOME/.config/hypr/current_wallpaper.$(echo "$wallpaper" | tr -d '"' | sed 's/.*\.//g')"

echo "preload = $wallpaper" | tr -d '"' | cat >"$HOME"/.config/hypr/hyprpaper.conf
echo "wallpaper = , $wallpaper" | tr -d '"' | cat >>"$HOME"/.config/hypr/hyprpaper.conf

hyprctl hyprpaper preload "$(echo "$wallpaper" | tr -d '"')" >/dev/null
hyprctl hyprpaper wallpaper ",$(echo "$wallpaper" | tr -d '"')" >/dev/null

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

echo "Wallpaper set: $wallpaper"
