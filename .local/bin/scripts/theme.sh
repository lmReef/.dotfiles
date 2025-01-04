if [[ -z $1 || ! -f $1 ]]; then
    wallpaper=~/Pictures/wallpapers/
else
    wallpaper=$1
fi

wal -i $wallpaper > /dev/null
wallpaper=$(jq .wallpaper ~/.cache/wal/colors.json)

if [[ -f ~/.config/hypr/current_wallpaper.* ]]; then
    rm ~/.config/hypr/current_wallpaper.*
fi
cp -lf $(echo $wallpaper | tr -d '"') "$HOME/.config/hypr/current_wallpaper.$(echo $wallpaper | tr -d '"' | sed 's/.*\.//g')"

echo "preload = $wallpaper" | tr -d '"' | cat > ~/.config/hypr/hyprpaper.conf
echo "wallpaper = , $wallpaper" | tr -d '"' | cat >> ~/.config/hypr/hyprpaper.conf

hyprctl hyprpaper preload "$(echo $wallpaper | tr -d '"')" > /dev/null
hyprctl hyprpaper wallpaper ",$(echo $wallpaper | tr -d '"')" > /dev/null

echo "Wallpaper set: $wallpaper"
