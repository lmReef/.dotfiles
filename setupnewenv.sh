#!/usr/bin/env bash

#
# script to set up all my stuff on in a new environment
#

# symlink configs
./createallsymlinks.sh

# install homebrew
if [[ -z "$(brew -v | grep 'Homebrew')" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install omz
if [[ -z "$ZSH" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# TODO: set up script for windows terminal theme
# https://github.com/sonph/onehalf/tree/master/windowsterminal

# homebrew installs
brew install \
git \
gh \
tmux \
neovim \
fzf \
glow \
zoxide \
curl \
gcc \
openjdk \
openjdk@21 \
tree-sitter \
util-linux \
feh \
ripgrep \
fd \
btop \
tldr \
bat \
jq \
mise

if [[ -z "$(gh auth status | grep 'Logged in')" ]]; then
    gh auth login
    gh auth setup-git
fi

# install tmux plugin manager
if [[ ! -d "~/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# set up nvim config and installs
if [[ ! -d "~/.config/nvim/" ]]; then
    mkdir ~/.config/
    pushd ~/.config/
    gh repo clone nvim-config
    mv nvim-config nvim
    # TODO: nvim . -c PackerSync
    popd
fi

# set up mise
mise use python
mise use java java@21

mise p i poetry
mise use poetry

mise set -g MISE_ENV_FILE=.env
mise set -g MISE_POETRY_VENV_AUTO=1
