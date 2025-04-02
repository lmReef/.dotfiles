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
alias ls="lsd -A --group-directories-first"
alias lst="lsd -A --group-directories-first --tree"
alias c="clear"
alias cls="clear && ls"
alias cat="bat -p"
alias ts="tmux-sessionizer.sh"
alias tss="tmux-sessions-fzf.sh"
alias tls="tmux ls"
alias nv="nvim"
alias nvd="nvim ."
alias nf="nextflow"
alias nfc="nf-core"
alias nft="nf-test"
alias h="help.sh"

# windows stuff
alias win="cd /mnt/c/Users/reefm"
alias desktop="cd /mnt/c/Users/reefm/Desktop"
alias proj="cd /mnt/c/Users/reefm/Desktop/Proj"
alias s="s.exe"
alias maps="maps.exe"
alias yt="yt.exe"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(fzf --zsh)"
eval "$(mise activate zsh)"

# load zsh tab completion
fpath+=~/.zfunc
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -Uz compinit && compinit

export NVIM_CONFIG="$HOME/.config/nvim/"
export BROWSER='/mnt/c/Program Files/Mozilla Firefox/firefox.exe'
export dl_dir='/mnt/c/Users/reef.matson/Downloads'

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/.p10k.zsh.
[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh

# tempus-developer: RC
if [ -f "/home/reef/.zshrc.tempus" ]; then
    . "/home/reef/.zshrc.tempus"
else
    echo "ERROR: The Tempus shell file (/home/reef/.zshrc.tempus) is missing!"
    echo "Please re-run https://github.com/tempuslabs/tempus-developer/blob/main/RUN-ONCE.sh"
fi
