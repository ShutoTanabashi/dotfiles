#!/bin/sh

dirset="/etc/homebrew"

# Make simbolic link for homebrew settings
if [ ! -d $dirset ]; then
    mkdir $dirset
fi
ln -s ~/dotfiles/homebrew/brew.env $dirset/brew.env
