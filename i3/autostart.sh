#!/usr/bin/env bash

variety &


export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx5 &

$HOME/.config/polybar/autostart.sh
pipewire &

picom -b
