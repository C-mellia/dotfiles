#!/bin/bash

if [[ -z $1 ]]; then
    DOTFILES_DIR=$HOME/dotfiles/
else
    DOTFILES_DIR=$1
fi

if [[ $(pacman 2&> /dev/null) ]]; then
    echo "Unsupported OS"
    exit 1
else
    echo "Installing packages..."
    sudo pacman -S --noconfirm --needed $(cat $DOTFILES_DIR/packages)
    if [[ ! -f /usr/bin/yay ]]; then
        echo "Installing yay..."
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
        rm -rf yay
    fi
fi


echo "Cloning tmux plugin manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Cloning Neovim Repo"
git clone https://github.com/neovim/neovim $HOME/softwares/neovim

echo "Building Neovim"
cd $HOME/softwares/neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

cd $DOTFILES_DIR

echo "Updating submodules..."
git submodules update --init

sudo chsh -s $(which zsh) $USER

echo "Installing rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installing rust packages..."
cargo install starship bat ripgrep fd-find

echo "Installing neovim plugins..."
nvim +PlugInstall +qall

echo "Installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo "Linking dotfiles..."
ln -s $DOTFILES_DIR/nvim $HOME/.config/nvim
ln -s $DOTFILES_DIR/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES_DIR/alacritty $HOME/.config/alacritty
sudo ln -s $DOTFILES_DIR/i3status.conf /etc/i3status.conf
ln -s $DOTFILES_DIR/.wezterm.lua $HOME/.wezterm.lua
ln -s $DOTFILES_DIR/i3 $HOME/.config/i3
ln -s $DOTFILES_DIR/newsboat $HOME/.config/newsboat
ln -s $DOTFILES_DIR/starship.toml $HOME/.config/starship.toml

echo "Installing fonts..."
bash $DOTFILES_DIR/font

echo "source ${DOTFILES_DIR}/zsh" >> ~/.zshrc

echo "All set"
