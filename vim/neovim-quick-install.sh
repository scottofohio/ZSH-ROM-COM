#!/bin/bash
#command line search pacakages that need to be installed https://www.chrisatmachine.com/Neovim/08-fzf/
mkdir ~/.config
git clone https://gist.github.com/02af8c9c09abc8e1046114e90decb419.git ~/.config/nvim

curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --headless +PlugInstall +qall
./nvim.appimage
