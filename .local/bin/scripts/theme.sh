#!/bin/zsh


if [[ -f "$1" ]]; then
    wallpaper="$1"
elif [[ "$1" == "wallhaven" ]] && [[ -n "$WALLHAVEN_API_KEY" ]]; then
    # TODO: the net side of this is probably better handled with js or py in another script
    base_query="?apikey=$WALLHAVEN_API_KEY&atleast=2560x1440"
    if [[ "$2" == "-s" ]]; then
        query="q=$3"
        json=$(curl -s "https://wallhaven.cc/api/v1/search${base_query}&$query")
    else
        # TODO: cache all /collections/ responses; split out to its own script and add to cron; currently only gets from page 1
        # cached_list="$HOME/.cache/wallhaven/json"
        # if [[ -f "$cached_list" ]] && [[ -n "$(cat "$cached_list")" ]]; then
        #     echo "using cached json $cached_list"
        #     json=$(cat "$cached_list")
        # else
        #     echo "no cached json, fetching"
        #     json=$(curl -s "https://wallhaven.cc/api/v1/collections/lmReef/1866068${base_query}")
        #     echo "$json" > "$cached_list"
        # fi

        # TODO: without -s flag still query but from collection items instead
        json=$(curl -s "https://wallhaven.cc/api/v1/collections/lmReef/1866068${base_query}")
    fi

    wall_id=$(echo "$json" | jq -r '.data[].id' | shuf -n1)
    detail=$(curl -s "https://wallhaven.cc/api/v1/w/${wall_id}?apikey=$WALLHAVEN_API_KEY")
    url=$(echo "$detail" | jq -r '.data.path')
    echo "$url"

    filename=$(basename "$url")
    wallhaven_dir="$HOME/.cache/wallhaven"
    mkdir -p "$wallhaven_dir" &>/dev/null
    wallpaper="$wallhaven_dir/$filename"

    if [[ ! -f "$wallpaper" ]]; then
        curl -s "$url" -o "$wallpaper"
    fi
else
    wallpaper="$(fd -d1 "$1" "$HOME/Pictures/wallpapers/" | shuf -n 1)"
fi

# copy wallpaper to persistent location for other process/configs to use w caching/reboots
ext="${$(basename "$wallpaper")##*.}"
current_wallpaper="$HOME/.cache/current_wallpaper.$ext"
rm ~/.cache/current_wallpaper.*
ln -f "$wallpaper" "$current_wallpaper"

wal -i "$wallpaper"

# hyprpaper
if ! pgrep hyprpaper &>/dev/null; then
    hyprctl --instance 0 dispatch exec hyprpaper
fi
echo -e "preload = $current_wallpaper\nwallpaper = , $current_wallpaper" | tr -d '"' | cat >"$HOME/.config/hypr/hyprpaper.conf"
hyprctl --instance 0 hyprpaper reload ",$(echo "$current_wallpaper" | tr -d '"')"

# create waybar style.css from template
waybar_stylesheet="$HOME/.config/waybar/style.css"
template="$HOME/.config/waybar/template-style.css"
wal_vars="$HOME/.cache/wal/colors"
cat "$template" >"$waybar_stylesheet"
index=0
for color in $(cat "$wal_vars"); do
    sed "s/var(--color$index)/$color/" <<<"$(cat "$waybar_stylesheet")" >"$waybar_stylesheet"
    ((index += 1))
done <"$wal_vars"
