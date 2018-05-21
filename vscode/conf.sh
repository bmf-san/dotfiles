#!/bin/sh

###########################
# vscode
###########################
while true;do
    printf "\e[32m[vscode] Do you want to update extensions list?\e[m\n"

    read answer
    case $answer in
        y)
          cd ${SCRIPT_DIR}/vscode && code --list-extensions > extensions && cd ../
          printf "\e[32m[vscode] updated extenstions list\e[m\n"
          break
          ;;
        n)
          printf "\e[32m[vscode] skipped\e[m\n"
          break
          ;;
        *)
          echo -e "cannot understand $answer. Please type y or n.\n"
          ;;
    esac
done
cat ${SCRIPT_DIR}/vscode/extensions | while read line
do
  code --install-extension $line
done

ln -nsf ${SCRIPT_DIR}/vscode/settings.json "${HOME}/Library/Application Support/Code/User/settings.json"
ln -nsf ${SCRIPT_DIR}/vscode/keybindings.json "${HOME}/Library/Application Support/Code/User/keybindings.json"

printf "\e[31m[Warning] You need to setup snippet files manually.\e[m\n"
printf "\e[32m[Complete] vscode\e[m\n"
