#!/bin/sh
#
# This works around bug where, by default, macOS 14.x writes part of a file
# immediately, and then doesn't update the directory for 20-60 seconds, causing
# the file system to be corrupted.
#

disky=`df | grep ADV360PRO | cut -d" " -f1`
sudo umount /Volumes/ADV360PRO
sudo mkdir /Volumes/ADV360PRO
sleep 2
sudo mount -v -o noasync -t msdos $disky /Volumes/ADV360PRO
