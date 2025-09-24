if [ -n "$1" ]; then
    wallpaper="$1"
else
    wallpaper="$HOME/Pictures/wallpaper.jpg"
fi
if [ -n "$2" ]; then
    lock="$2"
else
    lock="$HOME/Pictures/lock.jpg"
fi

convert -brightness-contrast -20x-20 -blur 0x12 "$wallpaper" "$lock"
