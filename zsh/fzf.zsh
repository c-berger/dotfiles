# Setup fzf
# ---------
if [[ ! "$PATH" == */home/chberger/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/chberger/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/chberger/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/chberger/.fzf/shell/key-bindings.zsh"

# Setup with fd-find
# ------------------
export FZF_DEFAULT_COMMAND='fd --follow --hidden --no-ignore --color=always --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"
