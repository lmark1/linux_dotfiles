#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

echo "$0: Installing tmux and tmuxinator"
sudo apt-get -y install tmux tmuxinator

FILE=$HOME/.tmux.conf
[ ! -e "$FILE" ] && ln -sf $MY_PATH/dottmux.conf $FILE && echo "$0: copying .tmux.conf"