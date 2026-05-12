#!/bin/bash
case "$1" in
clean)
    sed -E \
        -e "/MainhWnd/d" \
        -e "/(Trip|Total)(Copies|Pastes|Date)/d" \
        -e '/\([0-9]+x[0-9]+\)/d'
    ;;
smudge)
    cat
    ;;
*)
    cat
    ;;
esac
