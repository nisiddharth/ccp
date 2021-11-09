#!/usr/bin/sh

# ccp: color picker for X11
#
# Usage: ccp [rgb|h]
#   rgb: use rgb value instead of hex
#     h: help
# Report issues at: https://github.com/nisiddharth/ccp/
#
# Written by Nishchal Siddharth Pandey <https://github.com/nisiddharth/>

name="ccp"  # ccp color picker
image="/tmp/screen.png"
icon="/tmp/icon.png"
dependencies="xdotool xclip convert notify-send"
cr="\033[1;31m"
cg="\033[1;32m"
cb="\033[1;34m"

#help function
help() { printf "${cg}ccp: a x11 color picker\n
  Usage: ccp ${cb}[rgb|h]${cg}
  ${cb}  rgb:${cg} use rgb value instead of hex
  ${cb}    h:${cg} help
  ${cr}Report issues at: https://github.com/nisiddharth/ccp/\n" && exit;
}

#arguments
case "$1" in
  *rgb*) color_type="rgb";;
  *h*) help
    exit;;
  *) break;;
esac

#check dependencies
for dep in $dependencies; do
  if ! type $dep >/dev/null; then
    printf "${cr}$dep Not Found\n" && exit 1;
  fi
done

#get mouse position
mousex=$(xdotool getmouselocation | awk '{ print $1 }' | awk -F: '{ print $2}')
mousey=$(xdotool getmouselocation | awk '{ print $2 }' | awk -F: '{ print $2}')

import -window root $image
#get color value of pixel from the taken screenshot and the x,y cordinates of mouse.
rgb=$(convert $image -format "%[fx:int(255*p{$mousex,$mousey}.r)],%[fx:int(255*p{$mousex,$mousey}.g)],%[fx:int(255*p{$mousex,$mousey}.b)]" info:)
hex=$(convert $image -crop 1x1+$mousex+$mousey -depth 8 txt: | tail -n +2 | awk '{ print $3 }')

#create a png preview image for notification
convert -size 50x50 xc:"$hex" "$icon"

#copy rgb or hex according to the arguments
case "$color_type" in
  rgb) printf "$rgb" | xclip -sel c
    notify-send "$name" "$rgb" --icon="$icon";;
  *) printf "$hex" | xclip -sel c
    notify-send "$name" "$hex" --icon="$icon";;
esac
