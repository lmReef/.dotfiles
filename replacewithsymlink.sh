#!/usr/bin/env bash

if [[ -z $1 ]]; then
    echo "missing input arg"
    exit 1
elif [[ ! -e $1 ]]; then
    echo "no such file: $1"
    exit 1
fi

NEW_PATH="$(pwd -P)/$(basename $1)"

mv $1 .
echo "original file moved to $NEW_PATH"

cd "$(dirname $1)"
ln -nfs "$NEW_PATH"
echo "symlink created at $1"
