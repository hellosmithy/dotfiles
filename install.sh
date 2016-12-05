#!/bin/bash
set -e

VIMRC=~/.vimrc
AUTOLOAD=~/.vim/autoload
VIMEXE=vim
TMUXCONF=~/.tmux.conf
ZSHRC=~/.zshrc

if (which nvim > /dev/null); then
  VIMRC=~/.config/nvim/init.vim
  AUTOLOAD=~/.config/nvim/autoload
  VIMEXE=nvim
fi

cat <<WhatWillHappen
  I detected that you're using $VIMEXE.

  I'm going to...
    - move the following files:
	'$VIMRC' --> '$VIMRC.bak'
	'$TMUXCONF' --> '$TMUXCONF.bak'
	'$ZSHRC' --> '$ZSHRC.bak'
    - symlink:
        '$VIMRC' --> '$PWD/vimrc'
        '$TMUXCONF' --> '$PWD/tmux.conf'
        '$ZSHRC' --> '$PWD/zshrc'
    - install vim-plug
    - install all plugins listed in '$VIMRC'

  If you're not comfortable with these plans,
  you can abort now by pressing <C-c>.

WhatWillHappen

read THROW_AWAY

if [[ -f $VIMRC  ]]; then
  echo -n "Backing up existing vimrc... "
  mv $VIMRC $VIMRC.bak
  echo "done."
fi

if [[ -f $TMUXCONF  ]]; then
  echo -n "Backing up existing tmux.conf... "
  mv $TMUXCONF $TMUXCONF.bak
  echo "done."
fi

if [[ -f $ZSHRC  ]]; then
  echo -n "Backing up existing .zshconfig... "
  mv $ZSHRC $ZSHRC.bak
  echo "done."
fi

echo -n "Linking vimrc... "
ln -s $PWD/vimrc $VIMRC
echo "done."

echo -n "Linking tmux.conf... "
ln -s $PWD/tmux.conf $TMUXCONF
echo "done."

echo -n "Linking zshrc... "
ln -s $PWD/zshrc $ZSHRC
echo "done."

echo -n "Installing vim-plug... "
curl -sfLo $AUTOLOAD/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "done."

echo -n "Installing plugins... "
command $VIMEXE +PlugInstall +qall
echo "done."

cat <<NowThatWeAreDone
  Now that we are done you can...
    - add your own plugins to:
        '~/.vimrc.js/vimrc.plugs.local'
    - add your own settings to:
        '~/.vimrc.js/vimrc.local'

  If you add any new plugins to your 'plugs.local'
  file, make sure to run ':PlugInstall' from
  within $VIMEXE.

NowThatWeAreDone
