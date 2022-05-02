#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

mkdir -p ~/.config/nvim/
ln -sf ~/.vimrc ~/.config/nvim/init.vim
ln -sf $APP_PATH/dotvimrc ~/.vimrc

# link .ycm_extra_conf.py
ln -fs $APP_PATH/dotycm_extra_conf.py ~/.ycm_extra_conf.py
ln -fs $APP_PATH/default_ycm_extra_conf.py ~/.vim/default_ycm_extra_conf.py

# Link clang-tidy
ln -sf $APP_PATH/dotclang-tidy ~/.clang-tidy

# Link clang-format
ln -sf $APP_PATH/dotclang-format ~/.clang-format
