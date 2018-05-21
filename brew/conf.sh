#!/bin/sh

###########################
# brew
###########################
brew file init
brew file update
ln -sf ${SCRIPT_DIR}/brew/.config/brewfile/Brewfile ${HOME}/.config/brewfile/Brewfile
brew file install

printf "\e[32m[Complete] brew\e[m\n"
