#!/bin/sh

###########################
# tmux
###########################
ln -nsf ${SCRIPT_DIR}/tmux/.tmux.conf ${HOME}/.tmux.conf

printf "\e[32m[Complete] tmux\e[m\n"
