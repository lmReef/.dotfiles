echo ""
if tldr -l | grep -q "$1"; then
    $1 --help
    tldr $1
elif ! man $1; then
    $1 --help
fi
