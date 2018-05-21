#!/bin/sh

###########################
# vim
###########################
ln -nsf ${SCRIPT_DIR}/vim/.vim/vimrc ${HOME}/.vim/vimrc
ln -nsf ${SCRIPT_DIR}/vim/.vim/colors/solarized.vim ${HOME}/.vim/colors/solarized.vim

if [ ! -f ${HOME}/.vim/autoload/plug.vim ]; then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"

printf "\e[32m[Complete] vim\e[m\n"
