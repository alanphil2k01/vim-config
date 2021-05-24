#!/bin/sh

# Check for dependencies
clear
echo "Checking for dependencies"
if ! [ -x "$(command -v node)" ]; then
    echo 'Error: node is not installed.' >&2
    exit 1
fi
if ! [ -x "$(command -v npm)" ]; then
    echo 'Error: node is not installed.' >&2
    exit 1
fi

# git clone repo
echo "Cloning Repo"
git clone https://github.com/alanphil2k01/vim-config.git > /dev/null
cd vim-config

# Copying config files
echo "Copying vim files"
cp .vimrc ~/.vimrc > /dev/null

# Installing vim plug
echo "Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null

# Installing plugins 
echo "Installing plugins with Plug"
echo "Quit out of after its done by :qall"
sleep 5
vim +PlugInstall

# Installing 
echo "Opening .vimrc to install coc-extensions"
echo "Once done close out of it with :qall"
sleep 5
vim ~/.vimrc

# Deleting the repository
echo "Deleting vim-config repository"
cd ../
rm -rf vim-config > /dev/null

# Done
echo "All Done..."
