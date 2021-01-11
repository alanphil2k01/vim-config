#!/bin/sh

# Check for dependencies
clear
echo "Checking for dependencies"
if ! [ -x "$(command -v node)" ]; then
    echo 'Error: node is not installed.' >&2
    exit 1
fi
if ! [ -x "$(command -v npm)" ]; then
    echo 'Error: npm is not installed.' >&2
    exit 1
fi

# git clone repo
clear
echo "Cloning Repo"
git clone https://github.com/alanphil2k01/vim-config.git
cd vim-config/nvim

# Creating required directories
mkdir -p ~/.config/nvim

# Copying config files
clear
echo "Copying vim files"
cp -r init.vim ~/.config/nvim/init.vim
cp -r plugin ~/.config/nvim/

# Installing vim plug
clear
echo "Installing vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Installing plugins 
clear
echo "Installing plugins with Plug"
echo "Quit out of after its done by :qall"
sleep 5
nvim +PlugInstall

# Installing coc extensions
clear
echo "Opening init.vim to install coc-extensions"
echo "Once done close out of it with :qall"
sleep 5
nvim ~/.config/nvim/init.vim

# Deleting the repository
clear
echo "Deleting vim-config repository"
cd ../
rm -rf vim-config

# Done
clear
echo "All Done..."
