# dotfiles

If you're on macOS and have [homebrew](https://brew.sh) installed,
you can issue these commands:

```
git clone git@github.com:hellosmithy/dotfiles.git
cd dotfiles
./brew.sh
```

## Ruby

```
rbenv init
rbenv install 2.4.1 --verbose
```

## Python bindings

```
pyenv install 2.7.11
pyenv install 3.5.2

pyenv virtualenv 2.7.11 neovim2
pyenv virtualenv 3.5.2 neovim3

pyenv activate neovim2
pip install neovim
pyenv which python  # Note the path

pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path

# The following is optional, and the neovim3 env is still active
# This allows flake8 to be available to linter plugins regardless
# of what env is currently active.  Repeat this pattern for other
# packages that provide cli programs that are used in Neovim.
pip install flake8
ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH
```

## Updating

```
cd PATH/TO/dotfiles
git pull origin master
command $(which nvim || which vim) +PlugUpdate +qall
```

## neovim health check

Run `:CheckHealth` from inside neovim

## Sources

- The vim config and install script borrow heavily from [vimrc.js](https://github.com/zperrault/vimrc.js).
- MacOS config thanks to [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles).
- Various tmux and other bits from [r00k/dotfiles](https://github.com/r00k/dotfiles), [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles), [christoomey/dotfiles](https://github.com/christoomey/dotfiles)
