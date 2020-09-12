#!/bin/sh

# Copying config files
echo "Copying vim files"
cp -r .vim .vimrc $HOME

# Installing plugins 
echo "Installing plugins with Plug"
vim +PlugInstall&
