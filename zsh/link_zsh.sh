#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

if [ -f $HOME/.zshrc ]; then
    num=`cat $HOME/.zshrc | grep "dotzshrc" | wc -l`
    if [ "$num" -lt "1" ]; then
      echo "source $APP_PATH/dotzshrc" >> ~/.zshrc
    fi
fi