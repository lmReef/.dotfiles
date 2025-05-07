class_exists="$(hyprctl --instance 0 clients | grep "class: $1")"
title_exists="$(hyprctl --instance 0 clients | grep "title: $1")"

# echo "$class_exists"
# echo "$title_exists"

if [ -n "$class_exists" ]; then
    hyprctl --instance 0 dispatch focuswindow class:$1
elif [ -n "$title_exists" ]; then
    hyprctl --instance 0 dispatch focuswindow title:$1
else
    $1
fi
