# git worktree helpers
#
# gwt <branch>  - create a worktree for an existing branch
# gwtb <branch> - create a worktree and a new branch
# swt [name|-]  - fzf picker to switch between worktrees;
#                 pass a name to pre-filter, or - to go to the last worktree
#
# Worktrees are placed in a sibling directory: <project>.wt/<branch>
# Works from the main repo or from within an existing worktree.

_GWT_LAST=""

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

function _gwt_cd() {
  _GWT_LAST="$PWD"
  cd "$1"
}

function gwt() {
  local branch="${1:?Usage: gwt <branch>}"
  local main_root
  main_root=$(_gwt_main_root) || { echo "Error: not a git repository" >&2; return 1; }
  local wt_base="$(dirname "$main_root")/$(basename "$main_root").wt"
  local wt_path="$wt_base/$branch"
  mkdir -p "$wt_base"
  git worktree add "$wt_path" "$branch" && _gwt_cd "$wt_path"
}

function gwtb() {
  local branch="${1:?Usage: gwtb <branch>}"
  local main_root
  main_root=$(_gwt_main_root) || { echo "Error: not a git repository" >&2; return 1; }
  local wt_base="$(dirname "$main_root")/$(basename "$main_root").wt"
  local wt_path="$wt_base/$branch"
  mkdir -p "$wt_base"
  git worktree add -b "$branch" "$wt_path" && _gwt_cd "$wt_path"
}

function swt() {
  _gwt_main_root > /dev/null || { echo "Error: not a git repository" >&2; return 1; }

  if [[ "$1" == "-" ]]; then
    [[ -n "$_GWT_LAST" ]] || { echo "No previous worktree" >&2; return 1; }
    local dest="$_GWT_LAST"
    _gwt_cd "$dest"
    return
  fi

  local query_args=()
  [[ -n "$1" ]] && query_args=(--query "$1")

  # Show branch name in fzf; path is first field for cd
  local selected
  selected=$(git worktree list \
    | awk '{print $1, ($3 != "" ? $3 : "(detached)")}' \
    | sed 's/\[//;s/\]//' \
    | fzf -1 --with-nth=2 "${query_args[@]}")

  [[ -n "$selected" ]] && _gwt_cd "${selected%% *}"
}
