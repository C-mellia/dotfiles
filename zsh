# Plugins: 
source "${HOME}/dotfiles/minimal/minimal.zsh"
source "${HOME}/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export VISUAL=nvim
export EDITOR=nvim
export PATH="${PATH}:${HOME}/dotfiles/script"
unsetopt beep nomatch
bindkey -v

alias fzf-cd='cd $(dfzf)'

# Greeting: 
# echo '<(` ^´)>'
echo '(U w U)'

# stop annoying beepings of tty
setterm --bfreq 0 2> /dev/null
setterm --blen 0 2> /dev/null

stty stop 'undef'
