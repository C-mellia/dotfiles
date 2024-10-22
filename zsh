HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/camellia/.zshrc'

autoload -Uz compinit

compinit

autoload -U colors && colors
unsetopt beep nomatch
bindkey -v

alias fzf-cd='cd $(dfzf)'

set_proxy() {
    export http_proxy='http://127.0.0.1:20171/'
    export https_proxy='http://127.0.0.1:20171/'
}

unset_proxy() {
    unset http_proxy
    unset https_proxy
}

# Plugins:
# source "${HOME}/dotfiles/minimal/minimal.zsh"
# ∆
source "${HOME}/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

_italic() {
    echo -e "\e[3m$1\e[0m"
}

# Greeting: (Cute Ascii emos!)
# _italic '<(` ^´)>'
# echo '(> … <)'
echo '(˘ w ˘)'

# stop annoying beepings of tty
setterm --bfreq 0 2> /dev/null
setterm --blen 0 2> /dev/null

stty stop 'undef'

alias ls='/bin/env ls -C -F --color="always" -w $COLUMNS'
alias grep='/bin/env grep -n --color=always'

# use proxy
alias go="http_proxy=http://127.0.0.1:20171/ https_proxy=http://127.0.0.1:20171/ no_proxy=localhost,127.0.0.0/8,::1 go"
alias trans="http_proxy=http://127.0.0.1:20171/ https_proxy=http://127.0.0.1:20171/ no_proxy=localhost,127.0.0.0/8,::1 trans"
# coursier
alias cs="cs -J-Dhttps.proxyHost=127.0.0.1 -J-Dhttps.proxyPort=20171 -J-Dhttp.proxyHost=127.0.0.1 -J-Dhttp.proxyPort=20171"
alias sbt="sbt -J-Dhttps.proxyHost=127.0.0.1 -J-Dhttps.proxyPort=20171 -J-Dhttp.proxyHost=127.0.0.1 -J-Dhttp.proxyPort=20171"

export DOTFILES=${DOTFILES:-$HOME/dotfiles}
[[ -f $DOTFILES/envs ]] && source $DOTFILES/envs
