#!/bin/bash

## ask for admin
sudo -v

## check if python is installed
if command -v python &> /dev/null
then
    echo "Python is installed! Moving on."
else
    echo "Python is NOT installed, installing now."
    sudo pacman -S python
fi

## run installer
python ./src/installer.py
