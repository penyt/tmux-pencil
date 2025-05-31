#!/usr/bin/env bash

# echo "Hello"
TMUX_CONF="$HOME/.tmux.conf"

if [ -f "$TMUX_CONF" ]; then
  echo "You already have a .tmux.conf file in your home directory."
  echo ""
  read -p "Would you want to replace the original .tmux.conf file？ (y/n): " answer
  if [[ "$answer" == [Yy] ]]; then
    > "$TMUX_CONF"
    echo ".tmux.conf is now empty, start to make your new tmux config by tmux-pencil ! "
  else
    base="$TMUX_CONF.bak"
    backup="$base"
    index=1
    while [ -f "$backup" ]; do
      backup="$base$index"
      index=$((index + 1))
    done
    mv "$TMUX_CONF" "$backup"
    touch "$TMUX_CONF"
    echo ".tmux.conf is backed up, start to make your new tmux config by tmux-pencil ! "
  fi
else
  touch "$TMUX_CONF"
  echo "Start to make your new config by tmux-pencil ! "
fi

echo "Would you want to add interpretation comments in your .tmux.conf file？"
read -p "If choose no, you will get a completely concise config only with settings. (y/n): " add_comment
echo ""

read -p "Would you like to have whole background of your tmux status bar ？ (y/n): " color_bg


