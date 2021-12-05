# My vim config

## Neovim Setup
``` sh
git clone https://github.com/alanphil2k01/vim-config.git
cd vim-config
mkdir -p ~/.config
cp -r nvim ~/.config
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall
```
