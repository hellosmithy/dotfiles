#!/usr/bin/env zsh

ZAP_DIR="$HOME/.local/share/zap"

# Check if the directory exists
if [ -d "$ZAP_DIR" ]; then
    echo "Zap ⚡($ZAP_DIR) already installed. Skipping..."
else
    echo "Zap ⚡($ZAP_DIR) not detected. Installing..."
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
fi

