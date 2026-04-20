#!/bin/bash
case "$1" in
clean)
    sed -e "/File filename/d" \
        -e "/Find name/d"
    ;;
smudge)
    cat
    ;;
*)
    cat
    ;;
esac
