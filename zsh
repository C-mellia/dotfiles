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

autoload -Uz compinit

compinit

autoload -U colors && colors
unsetopt beep nomatch
bindkey -v

# Plugins:
# source "${HOME}/dotfiles/minimal/minimal.zsh"
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

alias fzf-cd='cd $(dfzf)'
alias ls='/bin/env ls -C -F --color="always" -w $COLUMNS'
alias grep='/bin/env grep -n --color=always'

export DOTFILES=${DOTFILES:-$HOME/dotfiles}
[[ -f $DOTFILES/envs ]] && source $DOTFILES/envs
