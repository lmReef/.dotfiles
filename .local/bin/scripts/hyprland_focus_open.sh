#!/bin/zsh

selector="$(hyprctl --instance 0 clients | grep -E "\s+\w+: $1" -m1 | sed -E "s/\s+(\w+): .+/\1/")"

# ignore="picture-in-picture"
cinfo="$(hyprctl --instance 0 clients)"

# pid based focus
all_pids="$(echo "$cinfo" | awk '/pid:/ {print $2}')"
matching_pid=""

for pid in "${all_pids[@]}"; do
    # $pid needs to be unquoted
    matching_pid="$(ps $pid | grep "$1" -m1 | awk '{split($0, x, "\\s"); print $1}')"
done

if [[ -n "$matching_pid" ]]; then
    hyprctl --instance 0 dispatch focuswindow "pid:$matching_pid" 1>/dev/null
else
    "$1" &
fi
