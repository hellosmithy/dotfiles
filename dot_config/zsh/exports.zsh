HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Local scripts
export PATH="$HOME/.local/bin":$PATH
# Obsidian CLI
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# telemetry opt-outs
export DO_NOT_TRACK=1
export HOMEBREW_NO_ANALYTICS=1
