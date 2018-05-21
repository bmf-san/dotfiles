#!/bin/sh

###########################
# git
###########################
ln -nsf ${SCRIPT_DIR}/git/.gitconfig ${HOME}/.gitconfig
ln -nsf ${SCRIPT_DIR}/git/git-completion.bash ${HOME}/git-completion.bash
ln -nsf ${SCRIPT_DIR}/git/git-prompt.sh ${HOME}/git-prompt.sh
ln -nsf ${SCRIPT_DIR}/git/.git_template/hooks/pre-push ${HOME}/.git_template/hooks/pre-push
ln -nsf ${SCRIPT_DIR}/git/.gitignore_global ${HOME}/.gitignore_global

printf "\e[32m[Complete] git\e[m\n"
