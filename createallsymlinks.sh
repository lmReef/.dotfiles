#!/usr/bin/env bash

if [[ -n $1 ]]; then
    BASE_DIR="$1"
    cd $1
else
    BASE_DIR=""
fi

echo ""
echo "===== processing $BASE_DIR ====="
echo ""

if [[ ! -d $(eval echo "~/$BASE_DIR") ]]; then
    mkdir $(eval echo "~/$BASE_DIR")
    echo "created dir ~/$BASE_DIR"
    echo ""
fi

for item in $(ls -A | grep -E '^\.'); do
    ITEM_PATH="$BASE_DIR$item"
    # echo "--- ~/$ITEM_PATH ---"

    # filter
    if [[ $item == ".git" ]]; then
        echo "[x] skipping $item"
        echo ""
        continue
    fi

    if [[ -d $item ]]; then
        # dir
        ./createallsymlinks.sh "$item/"
        echo "==========="
    else
        # file
        if [[ -h $(eval echo "~/$ITEM_PATH") ]]; then
            echo "[o] ~/$ITEM_PATH already exists"
        else
            ABS_FILE_PATH="$(pwd -P)/$item"
            SYMLINK_PATH="~/$ITEM_PATH"
            ln -fs $ABS_FILE_PATH $(eval echo "$SYMLINK_PATH")
            echo "[✓] created symlink $SYMLINK_PATH"
        fi
    fi

    echo ""
done
