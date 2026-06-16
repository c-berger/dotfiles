alias ll='exa -alF'
alias la='exa -a'
alias l='exa -alF'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias lg='lazygit'

alias bat='batcat'

alias gs='git status --short'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gp='git push'
alias gl='git log --oneline --all --graph --decorate'

alias path='echo "${PATH//:/\n}"'

function gc() { git commit -m "$*"; }

# Check if running in WSL by checking if the Linux kernel name contains "microsoft"
if [[ "$(uname -r)" == *[mM]icrosoft* ]]; then

    # "e": Opens the path directly in Windows Explorer
    function e() {
        if [ $# -eq 0 ]; then
            /mnt/c/Windows/explorer.exe .
        else
            /mnt/c/Windows/explorer.exe $(wslpath -m "$@")
        fi
    }
    function dc() {
        if [ $# -eq 0 ]; then
            /mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -path .
        elif [ $# -eq 1 ]; then
            /mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -path "$(wslpath -w "$1")"
        else
            /mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -path "$(wslpath -w "$1")" "$(wslpath -m "$2")"
        fi
    }
    function dcr() {
        if [ $# -eq 0 ]; then
            /mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -P R -R .
        else
            /mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -P R -R "$(wslpath -w "$1")"
        fi
    }
    function dcl() {
        if [ $# -eq 0 ]; then
            /mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -P L -L .
        else
            /mnt/c/Users/${USER}/scoop/shims/doublecmd.exe --no-splash --client -T -P L -L "$(wslpath -w "$1")"
        fi
    }

    alias rtt='/mnt/c/Program\ Files/SEGGER/JLink/JLinkRTTClient.exe'
fi


