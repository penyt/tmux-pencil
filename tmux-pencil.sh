#!/usr/bin/env bash
BOLD='\033[1m'
CYAN='\033[1;36m'
BLACK='\033[1;30m'
RED='\033[1;31m'
PURPLE='\033[1;35m'
RESET='\033[0m'

section_title() {
  title="$1"
  printf "${CYAN}${BOLD}✏ %-33s ${RESET}\n" "$title"
}

add_comments() {
  if [[ "$add_comment" == [1] ]]; then
    echo "# $1" >> "$TMUX_CONF"
  fi
}

echo ""
echo -e "      ${BLACK}+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}--${BLACK}%@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}------${BLACK}@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}---------${BLACK}@*"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}------------${BLACK}@@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}-------------${BLACK}@@@@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${PURPLE}++++++++++++${BLACK}@@@@@@@@@@${CYAN}-------------${BLACK}@@@@@@@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}+++++++++++++++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}-------------${BLACK}@@@@@@@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}+++++++++++++++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}-------------${BLACK}@@@@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}+++++++++++++++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}------------${BLACK}@@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}+++++++++++++++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}---------${BLACK}@*"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}+++++++++++++++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}------${BLACK}@"
echo -e "    ${BLACK}@${RED}+++++++${BLACK}@${PURPLE}+++++++++++++++++++++++++++${BLACK}@${PURPLE}++++++++++++${BLACK}@${PURPLE}++++++++${BLACK}@${CYAN}---${BLACK}@"
echo -e "      ${BLACK}+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${RESET}"
echo ""
echo "                    Hello! Welcome to tmux-pencil !"
echo ""
echo "       tmux-pencil will guide you step by step to set up your .tmux.conf"
echo "              Just follow the instructions and you’ll good to go!"
echo ""
echo ""
echo ""

if [ -z "$TMUX" ]; then
  echo "⚠️ WARNING"
  echo "You are not currently in a tmux session."
  echo "It is highly recommended to run this script inside a tmux session for better experience."
  read -p "Do you want to continue? [C]ontinue / [E]xit : " answer
  if [[ "$answer" == [Ee] ]]; then
    echo ""
    echo "Exiting tmux-pencil..."
    echo "Bye !!"
    exit 0
  fi
fi
echo ""

section_title "Back Up or Replace .tmux.conf"
TMUX_CONF="$HOME/.tmux.conf"
if [ -f "$TMUX_CONF" ]; then
  echo "A .tmux.conf file already exists in your home directory."
  echo "[1] Replace it directly (you'll lose your original config)."
  echo "[2] Make a backup."
  read -p " ✏️ (enter 1 or 2): " answer
  
  if [[ "$answer" == [1] ]]; then
    > "$TMUX_CONF"
    echo "  ►► .tmux.conf is now empty. Let's create your new tmux config with tmux-pencil !"
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
    echo "  ►► .tmux.conf is backed up. Let's create your new tmux config with tmux-pencil !"
  fi
else
  touch "$TMUX_CONF"
  echo "  ►► No existing config found. Let's create your new tmux config with tmux-pencil !"
fi
echo ""


section_title "Comment"
echo "Would you like to include explanatory comments in your .tmux.conf file?"
echo "[1] Yes, add comments."
echo "[2] No, concise config."
read -p " ✏️ (enter 1 or 2): " add_comment
echo ""

echo "set -g default-terminal \"tmux-256color\""  >> "$TMUX_CONF"
echo "set -ag terminal-overrides \",xterm-256color:RGB\"" >> "$TMUX_CONF"
echo "" >> "$TMUX_CONF"

section_title "Tmux Default Shell"
user_default_shell=$(getent passwd "$USER" | cut -d: -f7)
read -p "Default shell ✏️ : " ans_shell
if [[ -z "$ans_shell" ]]; then
  ans_shell="$user_default_shell"
  echo "  ►► Empty input. Your current default shell will be used."
fi
default_shell_path=$(command -v "$ans_shell")
if [[ -z "$default_shell_path" ]]; then
  echo "  ►► Invalid shell. It'll use your default shell."
  default_shell_path="$user_default_shell"
fi

echo ""

add_comments "Set the default shell for tmux sessions"
echo "set -g default-shell \"$default_shell_path\"" >> "$TMUX_CONF"
echo "" >> "$TMUX_CONF"

section_title "Prefix Keybinding"
echo -e "Default prefix key is \033[30;43m Ctrl+b \033[0m."
read -p "Would you like to change the default prefix key? ✏️ (y/n): " change_prefix
if [[ "$change_prefix" == [Yy] ]]; then
  echo ""
  echo -e "For default prefix Ctrl+b, we will say that \"trigger key\" is \033[30;43m ctrl \033[0m, and \"main key\" is \033[30;43m b \033[0m."
  read -p "Enter new trigger key (eg. ctrl, alt, shift) ✏️ : " prefix_trigger
  read -p "Enter new main key (eg. a, b, c...) ✏️ : " prefix_main
  if [[ "$prefix_trigger" == "alt" ]]; then
    new_prefix_trigger="M"
  elif [[ "$prefix_trigger" == "shift" ]]; then
    new_prefix_trigger="S"
  elif [[ "$prefix_trigger" == "ctrl" ]]; then
    new_prefix_trigger="C"
  else 
    echo "  ►► Invalid trigger key. Use Ctrl."
    new_prefix_trigger="C"
  fi

  if [[ -z "$prefix_main" ]]; then
    new_prefix_main="b"
  else
    new_prefix_main="$prefix_main"
  fi

else
  echo "  ►► Using default prefix key: Ctrl+b."
  new_prefix_trigger="C"
  new_prefix_main="b"
fi

tmux set-option prefix "$new_prefix_trigger-$new_prefix_main"

add_comments "Set the prefix key for tmux"
echo "set -g prefix $new_prefix_trigger-$new_prefix_main" >> "$TMUX_CONF"

add_comments "Unbind the original prefix key (Ctrl+b)"
echo "unbind C-b" >> "$TMUX_CONF"

add_comments "Bind your chosen key to act as prefix key"
echo "bind-key $new_prefix_trigger-$new_prefix_main send-prefix" >> "$TMUX_CONF"

echo "" >> "$TMUX_CONF"
echo "  ►► Your new prefix key is $new_prefix_trigger-$new_prefix_main."

echo ""

section_title "0-Based or 1-Based"
confirm=false
add_comments "Set the base index for tmux windows and panes"
while [ "$confirm" = false ]; do
  read -p "Would you like to use 0-based or 1-based indexing for windows and panes? ✏️ (0/1): " based
  if [[ "$based" == [1] ]]; then
    echo "  ►► Change to 1-based index. This will show effect only if you KILL the recent tmux server and REOPEN !"
    tmux set-option base-index 1
    tmux set-option pane-base-index 1
    tmux set-option renumber-windows on
    echo "set -g base-index 1" >> "$TMUX_CONF"
    echo "set -g pane-base-index 1" >> "$TMUX_CONF"
    echo "set -g renumber-windows on" >> "$TMUX_CONF"
    confirm=true
  else
    echo "  ►► Using default 0-based index."
    tmux set-option base-index 0
    tmux set-option pane-base-index 0
    tmux set-option renumber-windows on
    echo "set -g base-index 0" >> "$TMUX_CONF"
    echo "set -g pane-base-index 0" >> "$TMUX_CONF"
    echo "set -g renumber-windows on" >> "$TMUX_CONF"
    confirm=true
  fi
done
echo ""
echo "" >> "$TMUX_CONF"

section_title "Left Block Text (Session Name)"
confirm=false
add_comments "Adjust left-length to make all text visible"
echo -e "Choose text on the left. Default is \033[30;43m [#S] \033[0m."
echo -e "If you keep it empty, it'll use \033[30;43m session[#S] \033[0m :D"
echo ""
echo "💡 TIP: You can use #S for session name. Eg. session[#S] will show session[tpen], session[1], etc."
echo ""
while [ "$confirm" = false ]; do
  read -p "Always hit ENTER again to confirm ✏️ : " left_text
  if [[ -n "$left_text" ]]; then
    last_left_text=$left_text
  fi
  if [[ -z "$left_text" ]]; then
    if [[ -z "$last_left_text" ]]; then
      last_left_text="session[#S]"
      confirm=true
    else
      confirm=true
    fi
  fi
  tmux set-option status-left " $last_left_text "  
done
echo ""

stripped_text=$(echo "$last_left_text" | sed 's/#\[.*\]//g')
length=$(echo -n "$stripped_text" | wc -m)
buffer=20
left_length=$((length + buffer))
tmux set-option status-left-length "$left_length"
echo "set -g status-left-length $left_length" >> "$TMUX_CONF"

section_title "Left Block bg"
confirm=false
while [ "$confirm" = false ]; do
  read -p "Choose bg color of the left block ✏️ : " left_bg_color
  if [[ -n "$left_bg_color" ]]; then
    last_left_bg_color=$left_bg_color
  fi
  if [[ -z "$left_bg_color" ]]; then
    if [[ -z "$last_left_bg_color" ]]; then
      last_left_bg_color="blue"
      confirm=true
    else
      confirm=true
    fi
  fi
  tmux set-option status-left "#[bg=#{?client_prefix,$last_left_bg_color,$last_left_bg_color}] $last_left_text "
done
echo ""

section_title "Left Block prefix-on bg"
confirm=false
while [ "$confirm" = false ]; do
  read -p "Choose prefix-on bg color of the left block ✏️ : " left_prefix_bg_color
  if [[ -n "$left_prefix_bg_color" ]]; then
    last_left_prefix_bg_color=$left_prefix_bg_color
  fi
  if [[ -z "$left_prefix_bg_color" ]]; then
    if [[ -z "$last_left_prefix_bg_color" ]]; then
      last_left_prefix_bg_color="red"
      confirm=true
    else
      confirm=true
    fi
  fi
  tmux set-option status-left "#[bg=#{?client_prefix,$last_left_prefix_bg_color,$last_left_bg_color}] $last_left_text "
done
add_comments "\"client_prefix\" determines whether the prefix key is active"
add_comments "The first color is shown during prefix mode, the second is shown when prefix is inactive."
echo "set -g status-left \"#[bg=#{?client_prefix,$last_left_prefix_bg_color,$last_left_bg_color}] $last_left_text \"" >> "$TMUX_CONF"
echo ""
echo "-----"
echo "🧪 TEST: Press your prefix key to see the effect immediately."
read -p "[Dummy input] No matter what you type, press Enter to continue: " dummy_input
echo "-----"
echo ""

section_title "Status Bar bg Color"
confirm=false
echo "Status bar bg color is the main color of status bar."
echo -e "If you keep it empty, it'll use #394253, dark blue."
echo ""
while [ "$confirm" = false ]; do
  read -p "Choose status bar bg color ✏️ : " bg_color
  if [[ -n "$bg_color" ]]; then
    last_bg_color=$bg_color
  fi
  if [[ -z "$bg_color" ]]; then
    if [[ -z "$last_bg_color" ]]; then
      last_bg_color="#394253"
      confirm=true
    else
      confirm=true
    fi
  fi
  tmux set-option status-style "bg=$last_bg_color"
done

add_comments "This is the main color of the status bar (tmux-pencil default is set to #394253, dark blue)"
echo "set -g status-style \"bg=$last_bg_color\"" >> "$TMUX_CONF"
echo ""

section_title "Windows Tab"
confirm=false
while [ "$confirm" = false ]; do
  read -p "Put windows tab (eg. 0:zsh* 1:ssh) in the center ✏️ (y/n): " center_windows_tab
  if [[ "$center_windows_tab" == [Nn] ]]; then
    echo ""
  else
    tmux set-option status-justify centre
    echo "set -g status-justify centre" >> "$TMUX_CONF"
    echo ""
  fi
  confirm=true
done

echo "" >> "$TMUX_CONF"

section_title "Windows Status (Inactive)"
confirm=false
echo -e "Choose Windows Status text (inactive). Default is \033[30;43m #I:#W \033[0m."
echo "💡 TIPs: You can use #I for window's index, #W for window's name."
echo "         If you keep it empty, it will use default #I:#W."
echo ""

while [ "$confirm" = false ]; do
  read -p "Choose Windows Status text (inactive) ✏️ : " windows_text_ina
  if [[ -n "$windows_text_ina" ]]; then
    last_windows_text_ina=$windows_text_ina
  fi
  if [[ -z "$windows_text_ina" ]]; then
    if [[ -z "$last_windows_text_ina" ]]; then
      last_windows_text_ina="#I:#W"
      confirm=true
    else
      confirm=true
    fi
  fi
  tmux set-option -g window-status-format "$last_windows_text_ina"
  tmux refresh-client -S
done
echo ""
add_comments "Set the INACTIVE window status text format"

echo "set -g window-status-format \"$last_windows_text_ina\"" >> "$TMUX_CONF"

section_title "Windows Status (Active)"
confirm=false
echo -e "Choose Windows Status text (active). Default is \033[30;43m #I:#W* \033[0m."
echo "💡 TIPs: You can use #I for window's index, #W for window's name."
echo "         If you keep it empty, it will use   #I:#W  :D"
echo ""

while [ "$confirm" = false ]; do
  read -p "Choose Windows Status text (active) ✏️ : " windows_text_a
  if [[ -n "$windows_text_a" ]]; then
    last_windows_text_a=$windows_text_a
  fi
  if [[ -z "$windows_text_a" ]]; then
    if [[ -z "$last_windows_text_a" ]]; then
      last_windows_text_a=" #I:#W"
      confirm=true
    else
      confirm=true
    fi
  fi
  tmux set-option window-status-current-format "#[fg=#88C0D0] $last_windows_text_a"
done
echo ""
add_comments "Set the ACTIVE window status text format, fg is the text color"
echo "set -g window-status-current-format \"#[fg=#88C0D0] $last_windows_text_a\"" >> "$TMUX_CONF"

echo "" >> "$TMUX_CONF"

section_title "More Keybinds"

confirm=false
echo -e "Split the current pane become left & right, default is \033[30;43m Prefix + % \033[0m."
echo "If your input is empty, it'll still write into config to let you easily change it later."
echo ""
echo "💡 TIPs: You can use Prefix + main_key to try splitting."
echo "         Prefix + arrow_key : navigate through different panes"
echo "         Prefix + x ( + y ) : kill the current pane"
echo ""

while [ "$confirm" = false ]; do
  read -p "Enter your new main key (default is %) for splitting vertically, recommend \"|\" ✏️ : " split_lr
  if [[ -n "$split_lr" ]]; then
    last_split_lr=$split_lr
  fi
  if [[ -z "$split_lr" ]]; then
    if [[ -z "$last_split_lr" ]]; then
      last_split_lr="%"
      confirm=true
    else
      confirm=true
    fi
  fi
  tmux bind-key "$last_split_lr" split-window -h
done
echo ""

add_comments "Set the splitting left & right main key."
add_comments "Change the symbol in the next next line to change splitting main key"
echo "unbind %" >> "$TMUX_CONF"
echo "bind $last_split_lr split-window -h" >> "$TMUX_CONF"
echo "" >> "$TMUX_CONF"

confirm=false
echo -e "Split the current pane become up & down, default is \033[30;43m Prefix + \" \033[0m."
while [ "$confirm" = false ]; do
  read -p "Enter your new main key (default is \") for splitting horizontally, recommend \"-\" ✏️ : " split_ud
  if [[ -n "$split_ud" ]]; then
    last_split_ud=$split_ud
  fi
  if [[ -z "$split_ud" ]]; then
    if [[ -z "$last_split_ud" ]]; then
      last_split_ud="\""
      confirm=true
    else
      confirm=true
    fi
  fi
  tmux bind-key "$last_split_ud" split-window -v
done
echo ""

add_comments "Set the splitting up & down main key."
add_comments "Change the symbol in the next next line to change splitting main key"
echo "unbind '\"'" >> "$TMUX_CONF"
echo "bind '$last_split_ud' split-window -v" >> "$TMUX_CONF"
echo "" >> "$TMUX_CONF"

confirm=false
while [ "$confirm" = false ]; do
  echo -e "Using \033[30;43m Prefix + r \033[0m to reload (\`tmux source-file ~/.tmux.conf\`) is convenient."
  read -p "Do you want to set this keybinding? ✏️ (y/n): " reload_tmux_conf
  if [[ "$reload_tmux_conf" == [Nn] ]]; then
    echo ""
  else
    echo ""
    add_comments "Set Prefix + r to trigger \`tmux source-file ~/.tmux.conf\`"
    echo "unbind r" >> "$TMUX_CONF"
    echo "bind r source-file ~/.tmux.conf" >> "$TMUX_CONF"
    echo "" >> "$TMUX_CONF"
  fi
  confirm=true
done

section_title "Resize Pane"
confirm=false
while [ "$confirm" = false ]; do
  echo "Do you want to set the keybinds for resizing panes?"
  echo -e "Use \033[30;43m Prefix + h/j/k/l/m \033[0m to resize left/down/up/right/max."
  read -p "✏️ (y/n): " resize_keybind
  if [[ "$resize_keybind" == [Nn] ]]; then
    echo ""
  else
    echo "bind h resize-pane -L 5" >> "$TMUX_CONF"
    echo "bind j resize-pane -D 5" >> "$TMUX_CONF"
    echo "bind k resize-pane -U 5" >> "$TMUX_CONF"
    echo "bind l resize-pane -R 5" >> "$TMUX_CONF"
    echo "bind -r m resize-pane -Z" >> "$TMUX_CONF"
    echo "" >> "$TMUX_CONF"
    echo ""
  fi
  confirm=true
done

section_title "Reload Right Away"
reload_right_away=false
read -p "Do you want to reload tmux to get new config right away? ✏️ (y/n): " reload_right_away
if [[ "$reload_right_away" == [Nn] ]]; then
  echo ""
else
  tmux source-file ~/.tmux.conf
fi
echo ""
echo ""

echo "        ================================================================================="
echo "          Congratulations! You’ve successfully created your .tmux.conf with tmux-pencil."
echo "                  If you liked tmux-pencil, consider giving us a ⭐️ on GitHub!"
echo "                      Github repo: https://github.com/penyt/tmux-pencil"
echo "                                          Goodbye 👋"
echo "        ================================================================================="
echo ""

echo ""
echo ""
kill=false
read -p "Kill tmux server? Come back to see your new config working by executing command \`tmux\` ✏️ (y/n): " kill
if [[ "$kill" == [Nn] ]]; then
  echo ""
else
  tmux kill-server
fi

