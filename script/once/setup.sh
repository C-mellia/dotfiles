#!/bin/bash

if [[ -z $1 ]]; then
    DOTFILES_DIR=$HOME/dotfiles/
else
    DOTFILES_DIR=$1
fi

if [[ $(uname -s) == "Arch Linux" ]]; then
    echo "Installing packages..."
    sudo pacman -S --noconfirm --needed $(cat $DOTFILES_DIR/packages)
else
    echo "Unsupported OS"
    exit 1
fi

cd $DOTFILES_DIR
git submodules update --init

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

echo "Cloning tmux plugin manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "source ${DOTFILES_DIR}/zsh" >> ~/.zshrc


echo "All set"
