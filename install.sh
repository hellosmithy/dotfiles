#!/bin/bash
set -e

VIMRC=~/.vimrc
AUTOLOAD=~/.vim/autoload
VIMEXE=vim

if (which nvim > /dev/null); then
  VIMRC=~/.config/nvim/init.vim
  AUTOLOAD=~/.config/nvim/autoload
  VIMEXE=nvim
fi

cat <<WhatWillHappen
  I detected that you're using $VIMEXE.

  I'm going to...
    - install vim-plug
    - move your existing vimrc
        from: '$VIMRC'
	to:   '$VIMRC.bak'
    - symlink
        from: '$VIMRC'
	to:   '$PWD/vimrc'
    - install all plugins listed in
        '$VIMRC'

  If you're not comfortable with these plans,
  you can abort now by pressing <C-c>.

WhatWillHappen

read THROW_AWAY

echo -n "Installing vim-plug... "
curl -sfLo $AUTOLOAD/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "done."

if [[ -f $VIMRC  ]]; then
  echo -n "Backing up existing vimrc... "
  mv $VIMRC $VIMRC.bak
  echo "done."
fi

echo -n "Linking vimrc... "
ln -s $PWD/vimrc $VIMRC
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
