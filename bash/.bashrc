#!/bin/sh

###########################
# ssh
###########################
if [ -z “$SSH_CONNECTION” ]; then
  SSH_AGENT_FILE=$HOME/.ssh-agent
  [ -f $SSH_AGENT_FILE ] && source $SSH_AGENT_FILE
  ssh-add -l > /dev/null 2>&1
  if [ $? != 0 ]; then
    ssh-agent > $SSH_AGENT_FILE
    source $SSH_AGENT_FILE
    DIR=“$HOME/.ssh”
    for KEY in find $DIR -name '*id_rsa*' -not -name '*.pub'
    do
      ssh-add $KEY
    done
  fi
  unset SSH_AGENT_FILE
  unset DIR
  unset KEY
else
  SSH_AGENT_LINK=$HOME/.ssh/agent
  if [ -S $SSH_AUTH_SOCK ]; then
    case $SSH_AUTH_SOCK in
      /tmp/ssh-/agent.[0-9])
        ln -sf $SSH_AUTH_SOCK $SSH_AGENT_LINK;
        ;;
    esac
  fi
  if [ -S $SSH_AGENT_LINK ]; then
    export SSH_AUTH_SOCK=$SSH_AGENT_LINK
  fi
  unset SSH_AGENT_LINK
fi

###########################
# unix utility
###########################

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ex-shell='exec $SHELL -l'

# Remove .DS_Store files
alias rm-dsstore='find . -name ".DS_Store" -print -exec rm {} ";"'

# Count total files in current directory
function countFiles(){
	dir=$1
  find ${dir} -type f | wc -l
}
alias count-f=countFiles

# cd
alias up='cd ..'

# cd by selecting numbers
function cdSelect() {
	dirs=`ls -a`
	PS3="Select directory > "
        echo 'Directory list:'
        stty erase ^?
	select dir in ${dirs}
	do
		cd ${dir}
		break
	done
}
alias cd-s=cdSelect

# open by finder
alias f='open .'

# code grep
alias codegrep='find . -path ./.git -prune -o -path ./log -prune -o -type f -print0 | xargs -0 grep -n -E $1'

###########################
# docker
###########################

alias d='docker'
alias d-c='docker-compose'

###########################
# kubernetes
###########################

alias kc='kubectl'


###########################
# tmux
###########################

alias t='tmux'

function ide()
{
  tmux split-window -v -p 30
  tmux split-window -h -p 66
  tmux split-window -h -p 50
}
alias ide=ide

function multiSsh()
{
  tmux send-keys "ssh $1" C-m
  shift
  
  for i in $*;do
    tmux split-window
    tmux select-layout tiled
    tmux send-keys "ssh $i" C-m
  done
  
  tmux select-pane -t 0
  
  tmux attach-session -t $session
}
alias mssh=multiSsh

###########################
# git
###########################

alias g='git'

# git add all and stash it
function gitTrash()
{
  git add .
  git stash
}
alias g-trash=gitTrash

# git get current branch name
function gitGetCurrentBranchName()
{
  echo $(git rev-parse --abbrev-ref HEAD)
}

# git fetch origin current branch
function gitFetchOriginCurrentBranch()
{
  branch=$(git rev-parse --abbrev-ref HEAD)
  git fetch origin ${branch}
}
alias g-ft-cbr=gitFetchOriginCurrentBranch

# git pull --rebase origin current branch
function gitPullRebaseOriginCurrentBranch()
{
  branch=$(git rev-parse --abbrev-ref HEAD)
  git pull --rebase origin ${branch}
}
alias g-pl-rbs-cbr=gitPullRebaseOriginCurrentBranch

# git pull origin current branch
function gitPullOriginCurrentBranch()
{
  branch=$(git rev-parse --abbrev-ref HEAD)
  git pull origin ${branch}
}
alias g-pl-cbr=gitPullOriginCurrentBranch

# git force push to HEAD
function gitForcePushToHEAD()
{
  git push -f origin HEAD
}
alias g-fpsh-head=gitForcePushToHEAD

# git push origin current branch
function gitPushOriginCurrentBranch()
{
  branch=$(git rev-parse --abbrev-ref HEAD)
  git push origin ${branch}
}
alias g-psh-cbr=gitPushOriginCurrentBranch

# git review preparation
function gitReviewPreparation() {
  stty erase ^?
	branches=`git branch | grep -v -e"^\*" | tr -d ' '`
	PS3="Select a base branch > "
	echo 'Branch list:'
	select branch in ${branches}
	do
		git checkout ${branch}
		break
	done
	PS3="Select a review branch > "
	echo 'Branch list:'
	select branch in ${branches}
	do
    git merge --no-commit --no-ff ${branch}
		break
	done
  git reset
}
alias g-rvw-p=gitReviewPreparation

# git review finish
function gitReviewReset() {
  git reset --hard HEAD
  git clean -fd
}
alias g-rvw-r=gitReviewReset

# git log
alias g-lg='git log'

# git log --graph
alias g-lg--g='git log --graph'

# git commit --allow-empty
function gitCommitAllowEmpty() {   
  git commit --allow-empty; 
} 
alias g-cmt-emp=gitCommitAllowEmpty

# git rebase -i HEAD~var1
function gitRebaseInteractive() {
  stty erase ^?
  echo -n "How many commits do you want to get?"
  read var1
  git rebase -i HEAD~${var1}
}
alias g-rbs-i=gitRebaseInteractive

# create a new branch and checkout 
function gitCheckoutLocalBranch() {
  branches=`git branch | grep -v -e"^\*" | tr -d ' '`
  PS3="Select a branch > "
  echo 'Branch list:'
  select branch in ${branches}
  do
    git checkout ${branch}
    break
  done
}
alias g-cho-lcl=gitCheckoutLocalBranch

# checktout from a remote branch
function gitCheckoutRemoteBranch() {
	branches=`git branch -r | grep -v -e"^\*" | tr -d ' '`
        PS3="Select a branch > "
        echo 'Branch list:'
        stty erase ^?
        select branch in ${branches}
        do
  	  	  echo -n "What is the new branch name?"
        	read new_branch_name
        	git checkout -b ${new_branch_name} ${branch}
          break
        done
}
alias g-cho-rmt=gitCheckoutRemoteBranch

# delete a local branch
function gitDeleteLocalBranch() {
      branches=`git branch | grep -v -e"^\*" | tr -d ' '`
      PS3="Select a branch > "
      echo 'Branch list:'
      stty erase ^?
      select branch in ${branches}
      do
              git branch -D ${branch}
              break
      done
}
alias g-br-del=gitDeleteLocalBranch

# git delete all merged local branches
function gitDeleteMergedLocalBranches()
{
  git branch --merged|egrep -v '\*|master|main'|xargs git branch -d
}
alias g-br-del--merged=gitDeleteMergedLocalBranches

# add, commit, push to current branch
function gitLazy() {
      branch=$(git rev-parse --abbrev-ref HEAD)
      echo -n "Which files do you add?"
      stty erase ^?
      read -r var1
      git add ${var1}
      git commit
      git push origin ${branch}
}
alias g-lazy=gitLazy

# tmp commit to current branch
function gitTmp() {
      branch=$(git rev-parse --abbrev-ref HEAD)
      git add .
      git commit -m"tmp"
      git push origin ${branch}
}
alias g-tmp=gitTmp

# update remote branch list
alias g-update='git fetch --prune'

# clean files
alias g-cl-f='git clean -f'

# clean directories
alias g-cl-d='git clean -d'

