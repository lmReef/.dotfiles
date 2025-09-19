if status is-interactive
    fish_add_path \
        ~/.local/bin \
        ~/.local/bin/scripts \
        ~/.local/bin/rtg-tools \
        ~/.cargo/bin \
        ~/.config/tempus-app-manager/bin

    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
    mise activate fish | source
    zoxide init fish --cmd cd | source
    fzf --fish | source
end
