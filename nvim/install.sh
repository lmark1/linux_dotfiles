#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

var1="18.04"
var2=`lsb_release -r | awk '{ print $2 }'`
[ "$var2" = "$var1" ] && export BEAVER=1

sudo apt install -y python3-pip
# sudo apt-get -y install neovim
sudo apt-get install vim-gtk3 -y

sudo apt-get -y install libncurses5-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python3-dev clang-format
sudo -H pip3 install rospkg
sudo -H pip3 install wheel
sudo -H pip3 install grip
sudo apt install -y fonts-powerline

# source https://github.com/klaxalk/linux-setup/blob/master/appconfig/vim/install.sh
# if not on 20.04, g++-8 has to be installed manually
if [ -n "$BEAVER" ]; then
  sudo apt-get -y install g++-8
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8
  # add llvm repo for clangd and python3-clang
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
  sudo apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-11 main"
  # if 18.04, python3-clang has to be installed throught pip3 with prequisites manually from apt
  sudo apt-get -y install clang-11 libclang-11-dev
  sudo pip3 install clang
else
  # if 20.04, just install python3-clang from apt
  sudo apt-get -y install python3-clang 
fi

# install prequisites for YCM
sudo apt-get -y install clangd-11
# set clangd to version 11 by default
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-11 999
sudo apt-get -y install libboost-all-dev

sudo apt-get install -y markdown

cd ~/.vim/bundle/YouCompleteMe/
git submodule update --init --recursive
python3 ./install.py --clangd-completer 
