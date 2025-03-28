#!/usr/bin/env bash

session_name=$1
session_dir=$2

tmux new-window -dn cli
tmux send-keys -t cli "clear && ls" c-M

tmux new-window -dn long
tmux send-keys -t long "clear && ls" c-M

if [ -f "$session_dir/.tmux-hydrate.sh" ]; then
    source "$session_dir/.tmux-hydrate.sh"
fi

nvim .
