#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
	selected=$1
else
	selected=$(find ~/ ~/projects ~/dotfiles /Users/dani.fernandez/go/src/github.com/DataDog -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
	exit 0
fi

if [ -n "$TMUX" ]; then
	cd $selected || exit 1
	exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
	tmux new-session -s $selected_name -c $selected
	exit 0
fi

if tmux has-session -t=$selected_name 2>/dev/null; then
	tmux attach-session -t $selected_name
fi

tmux new-session -ds $selected_name -c $selected
