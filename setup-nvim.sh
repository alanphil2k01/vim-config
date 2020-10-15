#!/bin/sh

# git clone repo
clear
echo "Cloning Repo"
git clone https://github.com/alanphil2k01/vim-config.git
cd vim-config

# Checking for requried dirctories
if [ ! -d "~/.config"]; then
    mkdir -p ~/.config/nvim
fi
if [ ! -d "~/.config/nvim" ]; then
    mkdir ~/.config/nvim
fi

# Copying config files
clear
echo "Copying vim files"
cp -r .vimrc ~/.config/nvim/init.vim

# Installing vim plug
clear
echo "Installing vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Installing plugins 
clear
echo "Installing plugins with Plug"
echo "Quit out of after its done by :q"
sleep 5
nvim +PlugInstall

# Installing 
clear
echo "Opening .vimrc to install coc-extensions"
echo "Once done close out of it with :q"
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