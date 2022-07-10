#!/bin/bash
osCheck(){
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    OSCHECK=`cat /etc/*-release | grep ID=arch`
    if [ $OSCHECK ]
    then
      RETURN="Linux-GNU OS discovered: Arch Linux"
    else
      RETURN="GNU/Linux has been detected"
    fi
  else
    echo "Operating system incompatibility"
    echo "Press any key to exit ...."
    read
    exit
  fi
  echo "$RETURN"
}
aur(){
  cd ~
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd ~
  rm -rf yay
}
packageInstall(){
  sudo pacman -S neovim ripgrep bat python-pip python3 --noconfirm
  pip install pynvim
  yay -S nerd-fonts-source-code-pro --noconfirm
}
copyConfigs(){
  nvim -c 'PackerSync' \
    -c 'qa'
      nvim -c 'PackerClean' \
        -c 'qa'
              cd ~/dotfiles/homefolder/.config/
              cp -r nvim ~/.config
            }
