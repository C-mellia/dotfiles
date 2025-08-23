# rust
PATH="$HOME/.cargo/bin:$PATH"

# ruby
latest_ruby_dir=$(ls -td "$HOME/.local/share/gem/ruby/"*/bin 2> /dev/null | head -n 1)
[[ -z $latest_ruby_dir ]] || PATH="$latest_ruby_dir:$PATH"

# go
PATH="$HOME/go/bin:$PATH"

# java
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"

# jvm static link path
export LIBRARY_PATH="$JAVA_HOME/lib:$JAVA_HOME/lib/server/:$LIBRARY_PATH"

# runtime library path
export LD_LIBRARY_PATH="$HOME/.local/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/server/:$HADOOP_HOME/lib/native/:$LD_LIBRARY_PATH"

# hadoop c binding include path
export C_INCLUDE_PATH="$HADOOP_HOME/include/:$C_INCLUDE_PATH"

# proton version
# export PROTON_VERSION="Proton Experimental"
export PROTON_VERSION="GE-Proton9-21"

# proxies
export proxy_server="127.0.0.1"
export http_port="20171"
export socks_port="20170"

# use proxy
__proxy="http_proxy=http://$proxy_server:$http_port/ https_proxy=http://$proxy_server:$http_port/ no_proxy=localhost,127.0.0.0/8,::1"
alias go="$__proxy go"
alias trans="$__proxy trans"
# bundle
alias bundle="$__proxy bundle"
alias rails="$__proxy rails"

# local includes
C_INCLUDE_PATH=./include:$HOME/.local/include:$C_INCLUDE_PATH

# opencv includes
C_INCLUDE_PATH=/usr/include/opencv4:$C_INCLUDE_PATH

set_proxy() { export http_proxy='http://127.0.0.1:20171/' https_proxy='http://127.0.0.1:20171/'; }
unset_proxy() { unset http_proxy https_proxy; }

# pnpm
export PNPM_HOME="/home/camellia/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[[ -f $HOME/dotfiles/zsh ]] && source $HOME/dotfiles/zsh

:;
