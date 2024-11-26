#!/usr/bin/env bash

#
# script to set up all my stuff on in a new environment
#

# symlink configs
./createallsymlinks.sh

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
python3 \
uv \
tree-sitter \
util-linux \
feh

gh auth login
gh auth setup-git

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# set up nvim config and installs
mkdir ~/.config/
pushd ~/.config/
gh repo clone nvim-config
mv nvim-config nvim
# TODO: nvim . -c PackerSync
popd

