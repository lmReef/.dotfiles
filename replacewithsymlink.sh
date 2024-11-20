#!/usr/bin/env bash

if [[ -z $1 ]]; then
    echo "missing input arg"
    exit 1
elif [[ ! -e $1 ]]; then
    echo "no such file: $1"
    exit 1
# elif [[ -d $1 ]]; then
#     echo "$1 is a dir, to move all files use .../*"
#     exit 1
fi


NEW_PATH="$(pwd -P)/$(basename $1)"

echo "moving file(s)..."
if [[ -d $1 ]]; then
    shopt -s extglob
    mv -v "$1/*" ./
else
    echo "false"
    mv -v $1 .
fi

echo "file(s) moved. updating symlinks..."
./createallsymlinks.sh

# cd "$(dirname $1)"
# ln -nfs "$NEW_PATH"
# echo "symlink created at $1"
