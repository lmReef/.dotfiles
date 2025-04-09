class_exists="$(hyprctl --instance 0 clients | grep "class: $1")"
title_exists="$(hyprctl --instance 0 clients | grep "title: $1")"
window_pid="$(pgrep "$1" | head -n1)"

if [ -n "$class_exists" ]; then
    hyprctl --instance 0 dispatch focuswindow class:$1
elif [ -n "$title_exists" ]; then
    hyprctl --instance 0 dispatch focuswindow title:$1
elif [ -n "$window_pid" ]; then
    hyprctl --instance 0 dispatch focuswindow pid:$window_pid
else
    $1
fi
