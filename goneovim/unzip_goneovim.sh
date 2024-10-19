#!/bin/sh -e

# Check argument
if [ -z $1 ]; then
    echo "Usage: sudo ./unzip_goneovim.sh goneovim.tar.bz2"
    exit 1
fi

tar xvf $1 --directory=/usr/local
mv /usr/local/goneovim-* /usr/local/goneovim
ln -s /usr/local/goneovim/goneovim /usr/local/bin/goneovim
ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.6 /usr/lib/x86_64-linux-gnu/libtiff.so.5 
echo "If you need add desktop entry, run below command.
$ cp ~/dotfiles/goneovim/goneovim.desktop ~/.local/share/applications/goneovim.desktop"
