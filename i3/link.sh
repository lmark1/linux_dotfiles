#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

ln -fs $APP_PATH/doti3config ~/.config/i3/config
ln -fs $APP_PATH/doti3blocks ~/.config/i3/i3blocks.conf