alias ls='lsd'
alias ll='ls -la'
alias tmux-last='tmux attach-session -t "$(tmux list-sessions -F '#{session_name}:#{session_last_attached}' | sort -rk2,2 | cut -d: -f1 | head -n 1)"'