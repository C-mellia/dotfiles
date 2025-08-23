source "${0:A:h}/plugins.zsh"
source "${0:A:h}/completions.zsh"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify

zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# completions(optional, introduces delay to init a shell)
# which wezterm &> /dev/null && eval "$(wezterm shell-completion --shell zsh)"
# which qrcp &> /dev/null && eval "$(qrcp completion zsh)"
# which pip &> /dev/null && eval "$(pip completion --zsh)"
# which watchexec &> /dev/null && eval "$(watchexec --completions zsh)"

_italic() { echo -e "\e[3m$1\e[0m"; }
_cycle_fzf() { fzf --cycle $@; }

autoload -U colors && colors
unsetopt beep nomatch
bindkey -v

export _cycle_fzf

# stop annoying beepings of tty
setterm --bfreq 0 2> /dev/null
setterm --blen 0 2> /dev/null

stty stop 'undef'

# colorful
alias ls='/bin/env ls -C -F --color="always" -w $COLUMNS'
alias grep='/bin/env grep -n --color=always'

[[ -f $HOME/dotfiles/envs ]] && source $HOME/dotfiles/envs

# starship
which starship &> /dev/null && eval "$(starship init zsh)"

# Greeting: (Cute Ascii emos!)
# _italic '<(` ^´)>'
# echo '(> … <)'
echo '(˘ w ˘)'
