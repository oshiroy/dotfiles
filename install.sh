#!/usr/bin/env sh

ln -sf $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -sf $HOME/.dotfiles/bashrc $HOME/.bashrc
ln -sf $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.dotfiles/inputrc $HOME/.inputrc
ln -sf $HOME/.dotfiles/Xdefaults $HOME/.Xdefaults

ln -sf $HOME/.dotfiles/peco $HOME/.peco
ln -sf $HOME/.dotfiles/percol.d $HOME/.percol.d

#ssh
ln -sf $HOME/.dotfiles/ssh_config $HOME/.ssh/config

#.rosinstall
ln -sf $HOME/.dotfiles/oshiroy.rosintall $HOME/ros/indigo/src/.rosinstall
