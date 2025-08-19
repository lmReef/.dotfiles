#!/usr/bin/env zsh

source ~/.cache/wal/colors.sh

git_stuff() {
    git_branch="$(git rev-parse --abbrev-ref HEAD &>/dev/null)"
    git_status="$(git status -s &>/dev/null)"
    git_modified="$(echo "$git_status" | grep -c M)"
    git_untracked="$(echo "$git_status" | grep -c \?)"
    # git_stashed="$(git stash list | grep -c . 2>/dev/null)"

    line="%F{$color4}$git_branch%f $line %F{$color5}!$git_modified%f %F{$color6}?$git_untracked%f"
}

update_prompt() {
    line="%~"

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_stuff
    fi

    line="$(whoami) $line"

    PS1="$line > "
}
