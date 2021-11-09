# My vim config

## Neovim Setup
``` sh
git clone https://github.com/alanphil2k01/vim-config.git
cd vim-config
mkdir -p ~/.config/nvim
cp .vimrc ~/.config/nvim/init.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall
       ```

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
