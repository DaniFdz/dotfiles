#!/usr/bin/env bash

which fzf &>/dev/null || { echo "fzf not found"; exit 1; }

programming_languages=`echo "bash python lua cpp c typescript nodejs js rust" | tr ' ' '\n' `
core_utils=`echo "grep sed awk find sd fd git" | tr ' ' '\n'`
custom=`echo "custom" | tr ' ' '\n' | sort`

selected=`printf "$programming_languages\n$core_utils\n$custom" | sort | fzf`

if [[ -z "$selected" ]]; then
	exit 0
fi

read -p "Enter query: " query

if [ "$selected" = "custom" ]; then
	tmux neww bash -c "curl -s cht.sh/$query | less"
elif printf "$programming_languages" | grep -q "$selected"; then
	tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
	tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
