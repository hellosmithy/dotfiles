export GHQ_ROOT="$HOME/projects"

# fuzzy find git projects and auto-cd
function fzf-src () {
  local selected_dir=$(ghq list --full-path | fzf -1 -e)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src
