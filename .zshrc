#!/usr/bin/env bash

setopt HIST_IGNORE_SPACE

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"

export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1

# omz plugins
plugins=(colored-man-pages)

source $ZSH/oh-my-zsh.sh

# blinking cursor
_fix_cursor() {
   echo -ne '\e[1 q'
}
precmd_functions+=(_fix_cursor)

# custom PATH
path+=("$HOME/.local/bin/scripts")
path+=("$HOME/.local/bin")
path+=("$HOME/.cargo/bin")
# path+=("$HOME/anaconda3/bin")
export PATH

export NVIM_CONFIG="$HOME/.config/nvim/"
export VISUAL="nvim"
export EDITOR="nvim"
export WINE="/usr/bin/wine"
export WINETRICKS="/usr/bin/winetricks"

# users are encouraged to define aliases within the ZSH_CUSTOM folder.
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias hyprlandconfig="nvim ~/.config/hypr/hyprland.conf"
alias ls="lsd"
alias lst="lsd --tree -I .git -I .github -I .venv -I .nextflow -I .nf_test -I .pycache -I .pytest"
alias c="clear"
alias cls="clear && ls"
alias cat="bat -p"
alias ts="tmux-sessionizer.sh"
alias tss="tmux-sessions-fzf.sh"
alias tls="tmux ls"
alias nv="nvim"
alias nvd="nvim ."
alias co="codium"
alias cod="codium ."
alias nf="nextflow"
alias nfc="nf-core"
alias nft="nf-test"
alias h="help.sh"

[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh

eval "$(zoxide init zsh --cmd cd)"
eval "$(fzf --zsh)"
eval "$(mise activate zsh)"

# load zsh tab completion
fpath+=~/.zfunc
autoload -Uz compinit && compinit

neofetch
ls
