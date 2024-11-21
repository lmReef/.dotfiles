#!/usr/bin/env bash

#
# script to set up all my stuff on in a new environment
#

# symlink configs
./createallsymlinks.sh

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# tmux
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# nvim
brew install neovim
# pushd ~/.config/nvim
# nvim . -c PackerSync
# popd
