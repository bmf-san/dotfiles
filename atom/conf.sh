#!/bin/sh

###########################
# atom
###########################
while true;do
    printf "\e[32m[atom] Do you want to update packages list?\e[m\n"

    read answer
    case $answer in
        y)
          apm list --installed --bare > ${PWD}/atom/.atom/package.list
          printf "\e[32m[atom] updated packages list\e[m\n"
          break
          ;;
        n)
          printf "\e[32m[atom] skipped\e[m\n"
          break
          ;;
        *)
          echo -e "cannot understand $answer. Please type y or n.\n"
          ;;
    esac
done
apm install --packages-file ${SCRIPT_DIR}/atom/.atom/package.list
ln -sf ${SCRIPT_DIR}/atom/.atom/conig.cson ${HOME}/.atom/config.cson
ln -nsf ${SCRIPT_DIR}/atom/.atom/init.coffee ${HOME}/.atom/init.coffee
ln -nsf ${SCRIPT_DIR}/atom/.atom/keymap.cson ${HOME}/.atom/keymap.cson
ln -nsf ${SCRIPT_DIR}/atom/.atom/snippets.cson ${HOME}/.atom/snippets.cson
ln -nsf ${SCRIPT_DIR}/atom/.atom/styles.less ${HOME}/.atom/styles.less

printf "\e[32m[Complete] atom\e[m\n"
