#!/usr/bin/env zsh

# zsh config
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE

# load zsh tab completion
fpath+=~/.zfunc
autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# custom PATH
path+=("$HOME/.local/bin/scripts")
path+=("$HOME/.local/bin")
path+=("$HOME/.local/bin/rtg-tools/")
path+=("$HOME/.cargo/bin")
path+=("$HOME/.config/emacs/bin")
path+=("$HOME/.config/tempus-app-manager/bin/")
export PATH

# env
export NVIM_CONFIG="$HOME/.config/nvim/"
export VISUAL="nvim"
export EDITOR="nvim"
export WINE="/usr/bin/wine"
export WINETRICKS="/usr/bin/winetricks"

export FZF_DEFAULT_OPTS=""
export FZF_CTRL_T_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'tree -C {}'"

bindkey "^G" fzf-cd-widget
bindkey "^H" backward-delete-word
bindkey "^B" beginning-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias hyprlandconfig="nvim ~/.config/hypr/hyprland.conf"
alias ls="lsd -A"
alias lst="lsd -A --tree -I .git -I .github -I .venv -I .nextflow -I .nf_test -I .pycache -I .pytest"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cat="bat -p"
alias ts="tmux-sessionizer.sh"
alias tss="tmux-sessions-fzf.sh"
alias tls="tmux ls"
alias nv="nvim"
alias nvd="nvim ."
alias h="help.sh"
alias gls="gcloud storage ls"
alias gcat="gcloud storage cat"
alias gcp="gcloud storage cp"
alias gmv="gcloud storage mv"
alias grm="gcloud storage rm"
alias po="poetry"
alias cl="csvlens"
alias tl="csvlens -t"

# setup
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(fzf --zsh)"
eval "$(mise activate zsh)"

# custom prompt
source ~/.dotfiles/.local/bin/scripts/shell_prompt.sh
precmd_functions+=(update_prompt)

if [ -f "$HOME/.antigenrc" ]; then
    source "$HOME/.antigenrc"
fi

wal -qR

# tempus-developer: RC
if [ -f "/home/reef.matson/.zshrc.tempus" ]; then
    . "/home/reef.matson/.zshrc.tempus"
else
    echo "Please re-run https://github.com/tempuslabs/tempus-developer/blob/main/RUN-ONCE.sh"
fi

if [ -e /home/reef.matson/.nix-profile/etc/profile.d/nix.sh ]; then . /home/reef.matson/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
