# ls
alias ls='lsd'
alias ll='ls -la'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# safe mv, cp, rm
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# tmux
alias tmux-last='tmux attach-session -t "$(tmux list-sessions -F '#{session_name}:#{session_last_attached}' | sort -rk2,2 | cut -d: -f1 | head -n 1)"'

# neovim
alias n='nvim'

# git
alias g='git'
alias gc='git commit'
alias gcm='git commit -m'
alias ga='git add'
alias gp='git pull'
alias gP='git push'
alias gs='git status'
alias gco='git checkout'
alias gr='git rebase'
alias grm='git rebase $(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed "s@^refs/remotes/origin/@@") || git rebase master'
alias gst='git status'

