# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.bash" 2>/dev/null

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.bash"

# Setup with fd-find
# ------------------
export FZF_DEFAULT_COMMAND='fd --follow --hidden --no-ignore --color=always --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"
