#!/bin/bash
case "$1" in
clean)
    sed -e "/File filename/d" \
        -e "/Find name/d" \
        -e "/GUIConfig name=\"AppPosition\"/d" \
        -e "s/modelFileLastModifiedDate=\"[0-9]*\"/modelFileLastModifiedDate=\"0\"/" \
        | perl -0777 -pe 's/<History([^>]*)>\s*<\/History>/<History\1 \/>/s'
    ;;
smudge)
    cat
    ;;
*)
    cat
    ;;
esac
