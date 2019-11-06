#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Add cask for managing macOS applications
brew tap caskroom/cask
brew cask install dropbox
brew cask install google-chrome
brew cask install tower
brew cask install iterm2
brew cask install atom
brew cask install visual-studio-code

# Install zsh
brew install zsh
brew install zsh-completions

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
brew install stow

# Install runtime environment managers
brew install rbenv
brew install pyenv
brew install --HEAD pyenv-virtualenv

# Install neovim
brew install neovim/neovim/neovim

# Remove outdated versions from the cellar.
brew cleanup
