#!/usr/bin/bash

mkdir -p $HOME/.config
git clone https://github.com/alanphil2k01/vim-config.git $HOME/.config/nvim
# setup vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall
