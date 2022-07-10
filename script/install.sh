#!/bin/bash
echo "Greetings, $(/usr/bin/users)"
echo "Pls wait...."
source ./function.sh
osCheck()
if [[ "$RETURN" == "Linux-GNU OS discovered: Arch Linux" ]]; then
  aur()
  packageInstall() > /dev/null 2>&1
  copyConfigs() > /dev/null 2>&1
elif [[ "$RETURN" == "GNU/Linux has been detected" ]]; then
  sudo apt install neovim bat ripgrep python-pip python3 --yes --force-yes > /dev/null 2>&1
  copyConfigs() > /dev/null 2>&1
else
  echo "Your OS is not supported"
fi
