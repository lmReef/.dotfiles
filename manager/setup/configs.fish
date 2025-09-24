#!/bin/fish

function create_symlinks
    set -l base_path $argv[1]
    set -l dotfiles $argv[2..]
    set_color cyan
    echo -e "\n- $base_path -\n"
    set_color normal

    for dotfile in $dotfiles
        set -l config_name (basename $dotfile)
        set -l config_path "$base_path/$config_name"

        if test -e $config_path -a ! -L $config_path
            set_color yellow
            echo "local $config_name config already exists. skipping."
            continue
        end

        set_color normal
        echo "$dotfile --> $config_path"
        ln -sf $dotfile $base_path
    end

    set_color normal
    echo ""
end

echo "creating symlinks for config files..."

rm -r ~/.config/fish # fish needs to be deleted in here to ln, otherwise it regenerates itself

create_symlinks ~ $(find ~/.dotfiles/configs -maxdepth 1 -type f)
create_symlinks ~/.config $(find ~/.dotfiles/configs/.config -maxdepth 1 | grep -v '.config$')

echo "symlinks done."
