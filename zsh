# Plugins: 
source "${HOME}/dotfiles/minimal/minimal.zsh"
source "${HOME}/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export VISUAL=nvim
export EDITOR=nvim
export PATH="${PATH}:${HOME}/dotfiles/script"
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

# Greeting: 
# echo '<(` ^´)>'
echo '(U w U)'

# stop annoying beepings of tty
setterm --bfreq 0 2> /dev/null
setterm --blen 0 2> /dev/null

stty stop 'undef'
