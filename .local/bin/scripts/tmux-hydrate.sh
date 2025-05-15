#!/usr/bin/env bash

session_name=$1
session_dir=$2

tmux new-window -dn cli
tmux send-keys -t cli "clear && ls" c-M

# handle web projects
if ls | grep -q package.json; then
    tmux new-window -dn server
    tmux send-keys -t server "clear && ls" c-M

    if ! ls | grep -q node_modules; then
        tmux send-keys -t server "npm i; npm run dev" c-M
    else
        tmux send-keys -t server "npm run dev" c-M
    fi
fi

if [ -f "$session_dir/.tmux-hydrate.sh" ]; then
    source "$session_dir/.tmux-hydrate.sh"
fi

nvim .
