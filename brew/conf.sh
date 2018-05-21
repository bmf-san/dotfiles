#!/bin/sh

###########################
# brew
###########################
    cat << EOS
--------------------------------------------------
If you want to force update .Brewfile, run this:
brew bundle dump --global --force
--------------------------------------------------
EOS
ln -sf ${SCRIPT_DIR}/brew/.Brewfile ${HOME}/.Brewfile
brew bundle --global

printf "\e[32m[Complete] brew\e[m\n"
