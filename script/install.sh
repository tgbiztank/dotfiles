#!/bin/bash
#!/bin/sh
#_        _     _     _              _
#| |_ __ _| |__ (_)___| |_ __ _ _ __ | | __
#| __/ _` | '_ \| |_  | __/ _` | '_ \| |/ /
#| || (_| | |_) | |/ /| || (_| | | | |   <
#\__\__, |_.__/|_/___|\__\__,_|_| |_|_|\_\
#|___/

function arch_check(){
  if [ -f /etc/arch-release ]; then
    os="arch"
    return 0
  fi
  return 1
}
function yay_install(){
  if [[ $(yay -V | grep -c "yay") -eq 1 ]]; then
    return 0
  else
    git clone https://aur.archlinux.org/yay.git > /dev/null 2>&1 # install yay from AUR
    cd yay # cd to yay directory to install yay package manager
    makepkg -si # install yay
    cd .. && rm -rf yay # remove yay directory after installation
    if [[ $(yay -V | grep -c "yay") -eq 1 ]]; then # recheck
      return 0
    else
      return 1
    fi
  fi
}
function neovim_install() {
  if [ "$os" == "arch" ]; then
    yay_install # install yay if arch linux is detected and yay is not installed yet
    sudo pacman -S bat neovim python-pip ripgrep stylua xclip --noconfirm # neovim-python-client and some other dependencies
    yay -S nerd-fonts-space-mono --noconfirm # nerd fonts for neovim
    sudo pip install pynvim # neovim python plugin
  else
    clear && echo "neovim is not supported on this OS"
    fi
  }
  function neovim_config() {
    clear && echo "Maybe first time open nvim will get error, please ignore it"
    sleep 5 # wait user read the message
    git clone -b neovim https://github.com/tgbiztank/dotfiles.git ~/.config --depth 1 && nvim
    CHECK=$(echo $SHELL | grep -o "zsh") # check if zsh is used
    if [ "$CHECK" == "zsh" ]; then
      echo export VISUAL=nvim >> ~/.zshrc
      echo export EDITOR=nvim >> ~/.zshrc
      echo alias bizvim="~/.config/update.sh" >> ~/.zshrc
    elif [ "$CHECK" == "bash" ]; then
      echo export VISUAL=nvim >> ~/.bashrc
      echo export EDITOR=nvim >> ~/.bashrc
      echo alias bizvim="~/.config/update.sh" >> ~/.bashrc
    else
      echo "shell is not detected, please set VISUAL and EDITOR manually"
    fi
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.cache/nvim
    git clone -b neovim https://github.com/tgbiztank/dotfiles.git ~/.config --depth 1 && nvim
    rm -rf ~/.config/script
    rm -rf ~/.config/.github
  }

  function main() {
    arch_check # check if arch linux is detected
    neovim_install # install neovim
    neovim_config # config neovim automatically (if you want to config manually, please "cp -r ./nvim ~/.config/")
    clear && echo "Done!"
    xdg-open https://github.com/tgbiztank/ # open github page of this project to know more about this project and how to use it
  }
  main # run
