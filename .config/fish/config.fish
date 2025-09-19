if status is-interactive
    set -a PATH \
        ~/.local/bin \
        ~/.local/bin/scripts \
        ~/.cargo/bin

    if test -d /home/linuxbrew/
        /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
    end
    mise activate fish | source
    zoxide init fish --cmd cd | source
    fzf --fish | source
end
