if status is-interactive
    set -a PATH \
        ~/.local/bin \
        ~/.local/bin/scripts \
        ~/.dotfiles/scripts \
        ~/.cargo/bin

    set -x EDITOR nvim

    test -d /home/linuxbrew/ && /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
    mise activate fish | source
    zoxide init fish --cmd cd | source
    fzf --fish | source
end
