#!/bin/sh

###########################
# bash
###########################
ln -nsf ${SCRIPT_DIR}/bash/.bashrc ${HOME}/.bashrc
source ${HOME}/.bashrc
ln -nsf ${SCRIPT_DIR}/bash/.bash_profile ${HOME}/.bash_profile
source ${HOME}/.bash_profile
ln -nsf ${SCRIPT_DIR}/bash/.bash_logout ${HOME}/.bash_logout
ln -nsf ${SCRIPT_DIR}/bash/.inputrc ${HOME}/.inputrc

printf "\e[32m[Complete] bash\e[m\n"
