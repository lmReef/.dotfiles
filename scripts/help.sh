echo ""
if tldr -l | grep -q "$1"; then
    tldr $1
elif man $1; then
    man $1
else
    $1 --help
fi
