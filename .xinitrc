#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xsetroot -cursor_name left_ptr
setxkbmap -layout gb

if xrandr -q | grep -q "DVI-1 connected"; then
  xrandr --output DVI-0 --primary --left-of DVI-1 --output DVI-1 --auto
fi

nitrogen --restore

exec xmonad
# exec openbox-session
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
