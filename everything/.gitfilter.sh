#!/bin/bash
case "$1" in
clean)
    sed -e "/window_\(x\|y\|wide\|high\)/d"
    ;;
smudge)
    cat
    ;;
*)
    cat
    ;;
esac
