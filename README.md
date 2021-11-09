# My vim config

## Vim Setup

``` sh
git clone https://github.com/alanphil2k01/vim-config.git
cd vim-config
cp .vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall // This will install all the plugins
vim ~/.vimrc // This will install coc-extensions
```
