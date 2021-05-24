#!/bin/sh

# Check for dependencies
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
echo "Cloning Repo"
git clone https://github.com/alanphil2k01/vim-config.git > /dev/null
cd vim-config/nvim

# Creating required directories
mkdir -p ~/.config/nvim

# Copying config files
echo "Copying vim files"
cp init.vim ~/.config/nvim/init.vim > /dev/null
cp -r plugin ~/.config/nvim/ > /dev/null

# Installing vim plug
echo "Installing vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > /dev/null

# Installing plugins 
echo "Installing plugins with Plug"
echo "Ignore Errors by pressing Enter"
echo "Quit out of after its done by :qall"
sleep 5
nvim +PlugInstall

# Installing coc extensions
echo "Opening init.vim to install coc-extensions"
echo "Ignore Errors by pressing Enter"
echo "Once done close out of it with :qall"
sleep 5
nvim ~/.config/nvim/init.vim

# Deleting the repository
echo "Deleting vim-config repository"
cd ../
rm -rf vim-config > /dev/null

# Done
echo "All Done..."
