#!/bin/bash

if command -v pacman &>/dev/null; then
    echo "--- Install Zsh via Pacman ---------"
    sudo pacman -S --noconfirm --needed zsh eza fzf ripgrep fd zoxide

else
    echo "--- Install oh-my-zsh via Pacman ---------"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo "--- Clone oh-my-zsh Plugins ---------"
    if [ -z "$ZSH_CUSTOM" ]; then
        ZSH_CUSTOM="~/.oh-my-zsh/custom"
    fi
    git clone https://github.com/aloxaf/fzf-tab.git $ZSH_CUSTOM/plugins/fzf-tab
    git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-history-substring-search.git $ZSH_CUSTOM/plugins/zsh-history-substring-search
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

    source "$(dirname ${BASH_SOURCE[0]})/../fzf/install.sh"
fi
