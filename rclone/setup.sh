#!/bin/sh -e

# config file
srvc="rclone-googledrive.service"

# Check if config files exist
if [ ! -f ~/dotfiles/rclone/${srvc} ]; then
    echo "Error: File ${srvc} does not exist." 1>&2
    exit 1
fi

# Make directory for mount point.
mkdir -p ~/GoogleDrive # rclone-googledrive.service

# Make symbolic link for systemd.
mkdir -p ~/.config/systemd/user
ln -s ~/dotfiles/rclone/${srvc} ~/.config/systemd/user/${srvc}

# Set systemd
systemctl --user daemon-reload
systemctl --user start ${srvc}
systemctl --user enable ${srvc}
