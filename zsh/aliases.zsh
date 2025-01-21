alias ll='exa -alF'
alias la='exa -a'
alias l='exa -alF'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias lg='lazygit'

alias gs='git status --short'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gp='git push'
alias gl='git log --oneline --all --graph --decorate'

alias path='echo "${PATH//:/\n}"'

function gc() { git commit -m "$*"; }

alias e='/mnt/c/Windows/explorer.exe'
alias dc='/mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -path'
alias dcr='/mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -P R -R'
alias dcl='/mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -P L -L'

alias rtt='/mnt/c/Program\ Files/SEGGER/JLink/JLinkRTTClient.exe'

