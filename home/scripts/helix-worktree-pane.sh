  set -e

  GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ -z "$GIT_ROOT" ]; then
      echo "❌ Not in a git repository"
      exit 1
  fi

  REPO_NAME=$(basename "$GIT_ROOT")
  WORKTREE_BASE="$GIT_ROOT/../worktrees"

  # Function to list existing worktrees
  list_worktrees() {
      git worktree list | tail -n +2 | awk '{print $1}'
  }

  # Function to list branches
  list_branches() {
      git branch --all --format='%(refname:short)' | grep -v '^HEAD' | sort -u
  }

  # Create menu using fzf or simple select
  show_menu() {
      echo "=== Git Worktree Manager ==="
      echo "1) Create new worktree from existing branch"
      echo "2) Create new worktree with new branch"
      echo "3) Open existing worktree"
      echo "4) List all worktrees"
      echo ""
      read -p "Choose option (1-4): " choice
      echo "$choice"
  }

  # Main logic
  CHOICE=$(show_menu)

  case $CHOICE in
      1)
          # Create worktree from existing branch
          echo "Available branches:"
          BRANCHES=$(list_branches)

          # Use fzf if available, otherwise numbered list
          if command -v fzf &> /dev/null; then
              BRANCH=$(echo "$BRANCHES" | fzf --height=20 --prompt="Select branch: ")
          else
              select BRANCH in $BRANCHES; do
                  if [ -n "$BRANCH" ]; then
                      break
                  fi
              done
          fi

          if [ -z "$BRANCH" ]; then
              echo "No branch selected"
              exit 1
          fi

          # Clean branch name for directory
          CLEAN_BRANCH=$(echo "$BRANCH" | sed 's/origin\///' | tr '/' '-')
          WORKTREE_DIR="$WORKTREE_BASE/$REPO_NAME-$CLEAN_BRANCH"

          # Check if worktree already exists
          if [ -d "$WORKTREE_DIR" ]; then
              echo "⚠️  Worktree already exists at $WORKTREE_DIR"
              read -p "Open it anyway? (y/n): " confirm
              if [ "$confirm" != "y" ]; then
                  exit 0
              fi
          else
              mkdir -p "$WORKTREE_BASE"
              git worktree add "$WORKTREE_DIR" "$BRANCH"
              echo "✅ Created worktree: $WORKTREE_DIR"
          fi

          wezterm cli split-pane --right --cwd "$WORKTREE_DIR" -- bash -c "clear && echo '📁 Worktree: $BRANCH' && exec bash"
          ;;

      2)
          # Create new branch and worktree
          read -p "New branch name: " NEW_BRANCH

          if [ -z "$NEW_BRANCH" ]; then
              echo "Branch name cannot be empty"
              exit 1
          fi

          read -p "Base branch (default: main): " BASE_BRANCH
          BASE_BRANCH=${BASE_BRANCH:-main}

          CLEAN_BRANCH=$(echo "$NEW_BRANCH" | tr '/' '-')
          WORKTREE_DIR="$WORKTREE_BASE/$REPO_NAME-$CLEAN_BRANCH"

          mkdir -p "$WORKTREE_BASE"
          git worktree add "$WORKTREE_DIR" -b "$NEW_BRANCH" "$BASE_BRANCH"
          echo "✅ Created new worktree with branch: $NEW_BRANCH"

          wezterm cli split-pane --right --cwd "$WORKTREE_DIR" -- bash -c "clear && echo '📁 New worktree: $NEW_BRANCH' && exec bash"
          ;;

      3)
          # Open existing worktree
          EXISTING=$(list_worktrees)

          if [ -z "$EXISTING" ]; then
              echo "No existing worktrees found"
              exit 1
          fi

          echo "Existing worktrees:"
          if command -v fzf &> /dev/null; then
              WORKTREE_DIR=$(echo "$EXISTING" | fzf --height=20 --prompt="Select worktree: ")
          else
              select WORKTREE_DIR in $EXISTING; do
                  if [ -n "$WORKTREE_DIR" ]; then
                      break
                  fi
              done
          fi

          if [ -z "$WORKTREE_DIR" ]; then
              echo "No worktree selected"
              exit 1
          fi

          wezterm cli split-pane --right --cwd "$WORKTREE_DIR" -- bash -c "clear && echo '📁 Opened: $WORKTREE_DIR' && exec bash"
          ;;

      4)
          # List all worktrees
          echo ""
          echo "📋 All worktrees:"
          git worktree list
          read -p "Press enter to continue..."
          exit 0
          ;;

      *)
          echo "Invalid option"
          exit 1
          ;;
  esac
