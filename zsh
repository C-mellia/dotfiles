export VISUAL=nvim
export EDITOR=nvim
export PATH="${PATH}:${HOME}/dotfiles/script:${HOME}/.cargo/bin:${HOME}/.local/share/gem/ruby/3.0.0/bin:$PATH:${HOME}/go/bin"

autoload -U colors && colors
unsetopt beep nomatch
bindkey -v

alias fzf-cd='cd $(dfzf)'

set_proxy() {
    export http_proxy='http://localhost:20171/'
    export https_proxy='http://localhost:20171/'
}

unset_proxy() {
    unset http_proxy
    unset https_proxy
}

# Plugins:
# source "${HOME}/dotfiles/minimal/minimal.zsh"
source "${HOME}/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Greeting: (Cute Ascii emos!)
# echo '<(` ^´)>'
# echo '(U w U)'
echo '(> … <)'

# Keybinding from package minimal
alias ls='env ls -C -F --color="always" -w $COLUMNS'

# stop annoying beepings of tty
setterm --bfreq 0 2> /dev/null
setterm --blen 0 2> /dev/null

stty stop 'undef'
eval "$(starship init zsh)"
