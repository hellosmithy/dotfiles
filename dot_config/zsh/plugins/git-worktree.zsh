# git worktree helpers
#
# gwt <branch>  - create a worktree for an existing branch
# gwtb <branch> - create a worktree and a new branch
#
# Worktrees are placed in a sibling directory: <project>.wt/<branch>
# Works from the main repo or from within an existing worktree.

function _gwt_main_root() {
  # Returns the main project root, works from within worktrees too
  local common_dir
  common_dir=$(git rev-parse --git-common-dir 2>/dev/null) || return 1
  if [[ "$common_dir" != /* ]]; then
    # Relative path (.git) means we're in the main working tree
    git rev-parse --show-toplevel
  else
    # Absolute path means we're in a linked worktree
    dirname "$common_dir"
  fi
}

function gwt() {
  local branch="${1:?Usage: gwt <branch>}"
  local main_root
  main_root=$(_gwt_main_root) || { echo "Error: not a git repository" >&2; return 1; }
  local wt_base="$(dirname "$main_root")/$(basename "$main_root").wt"
  local wt_path="$wt_base/$branch"
  mkdir -p "$wt_base"
  git worktree add "$wt_path" "$branch"
}

function gwtb() {
  local branch="${1:?Usage: gwtb <branch>}"
  local main_root
  main_root=$(_gwt_main_root) || { echo "Error: not a git repository" >&2; return 1; }
  local wt_base="$(dirname "$main_root")/$(basename "$main_root").wt"
  local wt_path="$wt_base/$branch"
  mkdir -p "$wt_base"
  git worktree add -b "$branch" "$wt_path"
}
