# dotfiles

First, install [`neovim`](https://neovim.io/) with [Python3 support](https://github.com/neovim/python-client).

If you're on ~OS X~ macOS and have [homebrew](https://brew.sh) installed,
you can issue this command:

```
brew install python3 neovim/neovim/neovim; pip3 install neovim
```

```
git clone git@github.com:hellosmithy/dotfiles.git
cd dotfiles
./install.sh
```

On macOS `reattach-to-user-namespace` is required for the tmux configuration shell integration

```
brew install reattach-to-user-namespace
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
