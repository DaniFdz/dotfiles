#!/usr/bin/env bash

# AI Coding Worktree Setup
# Creates a new worktree with branch and launches AI coding layout

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Step 1: Select repository using fzf (similar to tmux-sessionizer)
echo -e "${BLUE}🔍 Select repository:${NC}"
SELECTED_REPO=$(find ~/ ~/projects ~/dotfiles ~/go/src/github.com -mindepth 1 -maxdepth 3 -type d -name ".git" 2>/dev/null | \
    sed 's/\.git$//' | \
    fzf --height 40% --reverse --border --prompt "Repository > ")

if [[ -z "$SELECTED_REPO" ]]; then
    echo -e "${RED}❌ No repository selected${NC}"
    exit 1
fi

# Get repo name
REPO_NAME=$(basename "$SELECTED_REPO")
echo -e "${GREEN}✓ Selected: $REPO_NAME${NC}\n"

# Check if it's a git repo
if [[ ! -d "$SELECTED_REPO/.git" ]]; then
    echo -e "${RED}❌ Not a git repository${NC}"
    exit 1
fi

cd "$SELECTED_REPO"

# Step 2: Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo -e "${BLUE}📍 Current branch: $CURRENT_BRANCH${NC}\n"

# Step 3: Ask for new branch name
echo -e "${BLUE}🌿 Enter new branch name:${NC}"
read -p "> " BRANCH_NAME

if [[ -z "$BRANCH_NAME" ]]; then
    echo -e "${RED}❌ Branch name cannot be empty${NC}"
    exit 1
fi

# Check if branch already exists
if git show-ref --verify --quiet refs/heads/"$BRANCH_NAME"; then
    echo -e "${YELLOW}⚠️  Branch '$BRANCH_NAME' already exists${NC}"
    read -p "Continue anyway? (y/n) > " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Step 4: Ask if worktree should be created
echo -e "\n${BLUE}🌲 Create worktree?${NC}"
echo "  (y) Yes - Create worktree in ~/.worktrees/${REPO_NAME}_${BRANCH_NAME}"
echo "  (n) No  - Just create branch in current repo"
read -p "> " -n 1 -r
echo

WORKTREE_DIR=""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Create worktree
    WORKTREE_DIR="$HOME/.worktrees/${REPO_NAME}_${BRANCH_NAME}"
    
    echo -e "\n${YELLOW}📦 Creating worktree...${NC}"
    
    # Create base worktrees directory if it doesn't exist
    mkdir -p "$HOME/.worktrees"
    
    # Check if worktree directory already exists
    if [[ -d "$WORKTREE_DIR" ]]; then
        echo -e "${RED}❌ Worktree directory already exists: $WORKTREE_DIR${NC}"
        read -p "Remove and recreate? (y/n) > " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git worktree remove "$WORKTREE_DIR" 2>/dev/null || rm -rf "$WORKTREE_DIR"
        else
            exit 1
        fi
    fi
    
    # Create worktree with new branch
    if git show-ref --verify --quiet refs/heads/"$BRANCH_NAME"; then
        git worktree add "$WORKTREE_DIR" "$BRANCH_NAME"
    else
        git worktree add -b "$BRANCH_NAME" "$WORKTREE_DIR"
    fi
    
    echo -e "${GREEN}✓ Worktree created: $WORKTREE_DIR${NC}"
    WORK_DIR="$WORKTREE_DIR"
else
    # Just create branch and switch to it
    if ! git show-ref --verify --quiet refs/heads/"$BRANCH_NAME"; then
        git checkout -b "$BRANCH_NAME"
        echo -e "${GREEN}✓ Branch created: $BRANCH_NAME${NC}"
    else
        git checkout "$BRANCH_NAME"
        echo -e "${GREEN}✓ Switched to branch: $BRANCH_NAME${NC}"
    fi
    WORK_DIR="$SELECTED_REPO"
fi

# Step 5: Launch tmux session with AI layout
SESSION_NAME="${REPO_NAME}_${BRANCH_NAME}"
SESSION_NAME=$(echo "$SESSION_NAME" | tr . _ | tr - _)

echo -e "\n${BLUE}🚀 Launching tmux session: $SESSION_NAME${NC}"

# Check if session already exists
if tmux has-session -t="$SESSION_NAME" 2>/dev/null; then
    echo -e "${YELLOW}⚠️  Session '$SESSION_NAME' already exists${NC}"
    read -p "Attach to existing session? (y/n) > " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        tmux attach-session -t "$SESSION_NAME"
        exit 0
    else
        exit 1
    fi
fi

# Create new session with AI layout
tmux new-session -d -s "$SESSION_NAME" -c "$WORK_DIR"

# Create the layout (same as tmux-ai-layout.sh but in the new session)
# Split vertically (create right column)
tmux split-window -h -p 40 -t "$SESSION_NAME" -c "$WORK_DIR"

# Go back to left pane and split horizontally
tmux select-pane -t "$SESSION_NAME:0.0"
tmux split-window -v -p 25 -t "$SESSION_NAME" -c "$WORK_DIR"

# Go to right top pane and split horizontally
tmux select-pane -t "$SESSION_NAME:0.2"
tmux split-window -v -p 25 -t "$SESSION_NAME" -c "$WORK_DIR"

# Assign commands to each pane
# Pane 0 (top-left): claude code
tmux send-keys -t "$SESSION_NAME:0.0" "claude code" C-m

# Pane 1 (bottom-left): terminal - ready

# Pane 2 (top-right): nvim
tmux send-keys -t "$SESSION_NAME:0.2" "nvim ." C-m

# Pane 3 (bottom-right): lazygit
tmux send-keys -t "$SESSION_NAME:0.3" "lazygit" C-m

# Focus back on claude-code panel
tmux select-pane -t "$SESSION_NAME:0.0"

# Attach to the session
echo -e "${GREEN}✓ Session created!${NC}\n"
sleep 0.5
tmux attach-session -t "$SESSION_NAME"
