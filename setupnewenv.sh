#!/usr/bin/env bash

#
# script to set up all my stuff on in a new environment
#

# symlink configs
./createallsymlinks.sh

# install homebrew
if [[ -z "$HOMEBREW_PREFIX" ]]; then
    echo "\nInstalling Homebrew...\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "\nHomebrew already installed.\n"
fi

# install omz
if [[ -z "$ZSH" ]]; then
    echo "\nInstalling OMZ...\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "\nOMZ already installed.\n"
fi

# TODO: set up script for windows terminal theme
# https://github.com/sonph/onehalf/tree/master/windowsterminal

# homebrew installs
echo "\nInstalling packages from Homebrew...\n"
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
    echo "\nAuthenticating Git...\n"
    gh auth login
    gh auth setup-git
else
    echo "\nGit already authenticated.\n"
fi

# install tmux plugin manager
if [[ ! -d "~/.tmux/plugins/tpm" ]]; then
    echo "\nInstalling tmux plugin manager...\n"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "\nTPM already installed.\n"
fi

# set up nvim config and installs
if [[ ! -d "~/.config/nvim/" ]]; then
    echo "\nSetting up Neovim...\n"
    mkdir ~/.config/
    pushd ~/.config/
    gh repo clone nvim-config
    mv nvim-config nvim
    # TODO: nvim . -c PackerSync
    popd
else
    echo "\nNeovim already set up.\n"
fi

# set up mise
if [[ -z "$MISE_ENV_FILE" ]]; then
    echo "\nSetting up Mise...\n"
    mise use -g python
    mise use -g java java@21

    mise p i poetry
    mise use -g poetry
    mise set -g MISE_ENV_FILE=.env
    mise set -g MISE_POETRY_VENV_AUTO=1
    poetry config virtualenvs.in-project true
else
    echo "\nMise already set up.\n"
fi
