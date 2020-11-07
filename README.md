# My vim config

## Dependancies

[nodejs](https://nodejs.org/en/) [npm](https://www.npmjs.com/)

## Vim Setup

### Manual Method
``` sh
git clone https://github.com/alanphil2k01/vim-config.git
cd vim-config
cp .vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall // This will install all the plugins
vim ~/.vimrc // This will install coc-extensions
```

### Automatic method
``` sh
curl -O https://raw.githubusercontent.com/alanphil2k01/vim-config/master/setup.sh 
sh setup.sh
```

## Neovim Setup

### Manual Method
``` sh
git clone https://github.com/alanphil2k01/vim-config.git
cd vim-config
mkdir ~/.config/nvim // Create if not present
cp .vimrc ~/.config/nvim/init.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall // This will install all the plugins
nvim ~/.config/nvim/init.vim // This will install coc-extensions
```

### Automatic method
``` sh
curl -O https://raw.githubusercontent.com/alanphil2k01/vim-config/master/setup-nvim.sh 
sh setup-nvim.sh
```
