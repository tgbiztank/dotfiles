#!/bin/bash
function update(){
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.cache/nvim
  git clone -b neovim https://github.com/tgbiztank/dotfiles.git ~/.config --depth 1 && nvim
}
update
