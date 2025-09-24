#!/bin/bash

config_path=~/.config/nvim

if [[ ! -d ~/.config/nvim ]]; then
    git clone https://github.com/lmReef/nvim-config "$config_path"
else
    echo "nvim config already found at $config_path"
fi
