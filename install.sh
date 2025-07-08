#!/bin/bash

## Ask for admin privileges
sudo -v
set +H

# Update system packages
echo "Updating system packages..."
sudo pacman -Syu --noconfirm

## Check if Python is installed
if command -v python &>/dev/null; then
    echo "Python is installed! Moving on."
else
    echo "Python is NOT installed, installing now."
    sudo pacman -S python --noconfirm
fi

## Check if yay is installed (required for some packages)
if command -v yay &>/dev/null; then
    echo "yay is installed! Moving on."
else
    echo "yay is NOT installed, installing yay now. To install some of these packages, yay is required."

    ## Check if Git is installed
    if command -v git &>/dev/null; then
        echo "Git is installed! Moving on."
    else
        echo "Git is NOT installed, installing Git now."
        sudo pacman -S git --noconfirm
    fi

    ## Check if base-devel group is installed
    if pacman -Qq base-devel &>/dev/null; then
        echo "base-devel is installed! Moving on."
    else
        echo "base-devel is NOT installed, installing base-devel now."
        sudo pacman -S --needed base-devel --noconfirm
    fi

    ## Install yay
    echo "Cloning yay repository..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    echo "Building yay package..."
    makepkg -si --noconfirm

    ## Verify yay installation
    yay --version &>/dev/null
    if [ $? -eq 0 ]; then
        echo "yay installed successfully, moving on..."
    else
        echo "Error: yay installation failed."
        exit 1
    fi
fi

## Run the installer script
echo "Running installer..."
python ./src/installer.py
