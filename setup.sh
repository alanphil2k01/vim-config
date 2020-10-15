#!/bin/sh

# git clone repo
clear
echo "Cloning Repo"
git clone https://github.com/alanphil2k01/vim-config.git
cd vim-config

# Copying config files
clear
echo "Copying vim files"
cp -r .vimrc ~/.vimrc

# Installing vim plug
clear
echo "Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Installing plugins 
clear
echo "Installing plugins with Plug"
echo "Quit out of after its done by :q"
sleep 5
vim +PlugInstall

# Installing 
clear
echo "Opening .vimrc to install coc-extensions"
echo "Once done close out of it with :q"
sleep 5
vim ~/.vimrc

# Deleting the repository
clear
echo "Deleting vim-config repository"
cd ../
rm -rf vim-config

# Done
clear
echo "All Done..."
