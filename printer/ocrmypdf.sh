#!/bin/bash

# OCR scans via posprocessing of Simple Scan tool
#
# Prepare:
# `pacman -S simple-scan tesseract-data-eng tesseract-data-deu`
# `yay -S ocrmypdf`
#
# Note: might need to install `sane` scan driver too:
# `pacman -S sane sane-airscan`
#
# Setup:
# In simple-scan preferences, enable posprocessing and put this script into `script` textbox:
# `/home/christoph/.dotfiles/printer/ocrmypdf.sh`
# Arguments are empty

ocrmypdf --language deu+eng --force-ocr "$3" "$3"
