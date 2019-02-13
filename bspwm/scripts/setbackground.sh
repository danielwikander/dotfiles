#!/bin/bash
FILE = $1   
FILETYPE = ${FILE#*.}
NEWFILE = "currentwallpaper.$FILETYPE"
cp FILE ~/Pictures/Wallpapers/$NEWFILE
