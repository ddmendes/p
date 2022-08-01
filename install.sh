#!/bin/sh

# Install location for p utility
P_PATH=${P_PATH:=$HOME/.p}

# $HOME is defined at the time of login, but it could be unset. If it is unset,
# a tilde by itself (~) will not be expanded to the current user's home directory.
# POSIX: https://pubs.opengroup.org/onlinepubs/009696899/basedefs/xbd_chap08.html#tag_08_03
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
# macOS does not have getent, but this works even if $HOME is unset
HOME="${HOME:-$(eval echo ~$USER)}"

mkdir -p $P_PATH
pushd $P_PATH
git clone https://github.com/ddmendes/p.git

case $(basename $SHELL) in
bash) echo "bash case" ;;
zsh) echo "zsh case";;
fish) echo "fish case" ;;
esac

popd