#!/bin/sh

. ./util.sh

# functions
function setExecuteFlag() {
  while true;do
      echo "$1: "

      read answer
      case $answer in
          y)
            return 1
            break
            ;;
          n)
            return 0
            break
            ;;
          *)
            echo -e "cannot understand $answer. Please type y or n.\n"
            ;;
      esac
  done

  return 
}

# check options
for OPTION in "$@"
do
    case $OPTION in
        '-i' )
            FLAG_I=1
            ;;
    esac
    shift
done

# execute
if [ "$FLAG_I" ]; then
  stty erase ^?
  
  setExecuteFlag bash
  BASH=$?

  setExecuteFlag brew
  BREW=$?

  setExecuteFlag anyenv
  ANYENV=$?

  setExecuteFlag git
  GIT=$?

  setExecuteFlag mac
  MAC=$?

  setExecuteFlag tmux
  TMUX=$?

  setExecuteFlag vim
  VIM=$?

  setExecuteFlag vscode
  VSCODE=$?

  if [ "$BASH" == 1 ]; then
    . bash/conf.sh
  fi

  if [ "$BREW" == 1 ]; then
    . brew/conf.sh
  fi

  if [ "$ANYENV" == 1 ]; then
    . anyenv/conf.sh
  fi

  if [ "$GIT" == 1 ]; then
    . git/conf.sh
  fi

  if [ "$MAC" == 1 ]; then
    . mac/conf.sh
  fi

  if [ "$TMUX" == 1 ]; then
    . tmux/conf.sh
  fi

  if [ "$VIM" == 1 ]; then
    . vim/conf.sh
  fi

  if [ "$VSCODE" == 1 ]; then
    . vscode/conf.sh
  fi
else
  . bash/conf.sh
  . brew/conf.sh
  . anyenv/conf.sh
  . git/conf.sh
  . mac/conf.sh
  . tmux/conf.sh
  . vim/conf.sh
  . vscode/conf.sh
fi

###########################
# Done
###########################
printf "\e[32mDone!\e[m\n"
