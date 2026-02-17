#!/usr/bin/env bash

# AI Coding Layout for tmux
# Layout: claude-code (top-left 75%x60%) | nvim (top-right 75%x40%)
#         terminal (bottom-left 25%x60%) | lazygit (bottom-right 25%x40%)

# Get current directory
CURRENT_DIR=$(pwd)

# Create the layout
# Start with one pane, split it vertically (columns)
tmux split-window -h -p 40 -c "$CURRENT_DIR"

# Go back to left pane and split it horizontally (rows)
tmux select-pane -t 0
tmux split-window -v -p 25 -c "$CURRENT_DIR"

# Go to right top pane and split it horizontally
tmux select-pane -t 2
tmux split-window -v -p 25 -c "$CURRENT_DIR"

# Now assign commands to each pane
# Pane 0 (top-left): claude-code/opencode
tmux select-pane -t 0
tmux send-keys "claude code" C-m

# Pane 1 (bottom-left): terminal - already ready, do nothing

# Pane 2 (top-right): nvim
tmux select-pane -t 2
tmux send-keys "nvim ." C-m

# Pane 3 (bottom-right): lazygit
tmux select-pane -t 3
tmux send-keys "lazygit" C-m

# Focus back on claude-code panel
tmux select-pane -t 0
