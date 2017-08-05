#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh

# Install other useful binaries.
brew install ack
brew install git
brew install tree
brew install tmux
brew install reattach-to-user-namespace # required for the tmux configuration shell integration on macOS
brew install fzf
brew install the_silver_searcher

# Install runtime environment managers
brew install rbenv; rbenv init
brew install pyenv
brew install --HEAD pyenv-virtualenv

# Remove outdated versions from the cellar.
brew cleanup
