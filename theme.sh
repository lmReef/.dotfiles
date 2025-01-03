if [[ -z $1 || ! -f $1 ]]; then
    wallpaper=~/Pictures/1440p/
else
    wallpaper=$1
fi

wal -i $wallpaper > /dev/null

wallpaper=$(jq .wallpaper ~/.cache/wal/colors.json)
echo "preload = $wallpaper" | tr -d '"' | cat > ~/.config/hypr/hyprpaper.conf
echo "wallpaper = , $wallpaper" | tr -d '"' | cat >> ~/.config/hypr/hyprpaper.conf

hyprctl hyprpaper preload "$(echo $wallpaper | tr -d '"')" > /dev/null
hyprctl hyprpaper wallpaper ",$(echo $wallpaper | tr -d '"')" > /dev/null

echo "Wallpaper set: $wallpaper"
