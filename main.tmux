#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

default_key_bindings_goto="l"
tmux_option_goto="@fzf-goto-session"

get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo $default_value
  else
    echo $option_value
  fi
}

function set_goto_session_bindings {
  local key_bindings=$(get_tmux_option "$tmux_option_goto" \
    "$default_key_bindings_goto")
  local key
  for key in $key_bindings; do
    tmux bind "$key" split-window -p 80 "$CURRENT_DIR/scripts/switch_session_fzf.sh"
  done
}

function main {
  set_goto_session_bindings
}
main
