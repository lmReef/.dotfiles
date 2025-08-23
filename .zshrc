#!/bin/zsh

#
# zsh config
#

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE

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

bindkey "^G" fzf-cd-widget
bindkey "^H" backward-delete-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

#
# env
#

# TODO: handle userspace path with mise
path+=("$HOME/.local/bin")
path+=("$HOME/.local/bin/scripts")
path+=("$HOME/.cargo/bin")
path+=("$HOME/.config/emacs/bin")
export PATH

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

#
# tool config
#

eval "$(zoxide init zsh --cmd cd)"
eval "$(fzf --zsh)"
eval "$(mise activate zsh)"

if [[ -f "$HOME/.antigenrc" ]]; then
    source "$HOME/.antigenrc"
fi

# alacritty doesnt apply theme on start
if command -v wal &>/dev/null && [ "$TERM" = "alacritty" ]; then
    wal -Rqe
fi

fpath+=~/.zfunc
autoload -z compinit && compinit

#
# aliases
#

alias ls="lsd -A"
alias lst="lsd -A --tree -I .git -I .github -I .venv -I .nextflow -I .nf_test -I .pycache -I .pytest"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
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
alias get_esp="source /opt/esp-idf/export.sh"

#
# custom
#

source ~/.dotfiles/.local/bin/scripts/shell_prompt.sh
precmd_functions+=(update_prompt)

neofetch
