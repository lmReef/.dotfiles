#!/usr/bin/env bash

if [[ -n $1 ]]; then
    DIR_NAME="$1"
    pushd $1
else
    DIR_NAME=""
fi

echo ""
echo "===== processing $DIR_NAME ====="
echo ""

# if dir doesnt exist in ~/ then create it
if [[ ! -d $(eval echo "~/$DIR_NAME") ]]; then
    mkdir $(eval echo "~/$DIR_NAME")
    echo "created dir ~/$DIR_NAME"
    echo ""
fi

for item in $(ls -A); do
    ITEM_PATH="$DIR_NAME$item"
    # echo "--- ~/$ITEM_PATH ---"

    # filter
    if [[ $item == ".git" ]]; then
        echo "[x] skipping $item"
        echo ""
        continue
    fi

    if [[ -d $item ]]; then
        # dir
        popd
        ./createallsymlinks.sh "$ITEM_PATH/"
    else
        # file
        if [[ -h $(eval echo "~/$ITEM_PATH") ]]; then
            read -n1 -p "[o] ~/$ITEM_PATH already exists, overwrite? (y/n): " WRITE_FILE
            echo ""
        else
            WRITE_FILE="y"
        fi
        if [[ $WRITE_FILE == [yY] ]]; then
            ABS_FILE_PATH="$(pwd -P)/$item"
            SYMLINK_PATH="~/$ITEM_PATH"
            ln -fs $ABS_FILE_PATH $(eval echo "$SYMLINK_PATH")
            echo "[✓] created symlink $SYMLINK_PATH"
        fi
    fi

    echo ""
done
