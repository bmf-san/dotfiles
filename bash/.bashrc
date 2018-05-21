#!/bin/sh

###########################
# ssh
###########################

SSH_KEY_LIFE_TIME_SEC=31536000
SSH_AGENT_FILE=$HOME/.ssh-agent
test -f $SSH_AGENT_FILE && source $SSH_AGENT_FILE > /dev/null 2>&1
if [ $( ps -ef | grep ssh-agent | grep -v grep | wc -l ) -eq 0 ]; then
    ssh-agent -t $SSH_KEY_LIFE_TIME_SEC > $SSH_AGENT_FILE
    source $SSH_AGENT_FILE > /dev/null 2>&1
    for key in `find ~/.ssh -name *rsa`
    do
      ssh-add -K ${key}
	  done
fi

###########################
# unix utility
###########################

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

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
# atom
###########################

function atomOptimize() {
	cd ~/.atom
	rm -rf compile-cache/*
	echo 'Remove all compile-cache files'
	rm -rf storage/*
	echo 'Remove all storage files'
	cd -
}
alias atom-optimize=atomOptimize

###########################
# vagrant
###########################

alias v-up='vagrant up'
alias v-halt='vagrant halt'
alias v-ssh='vagrant ssh'
alias v-reload='vagrant reload'
alias v-provision='vagrant provision'

###########################
# docker
###########################

alias d='docker'
alias d-c='docker-compose'
alias d-rm-a='docker rm $(d ps -a -q)'
alias d-rmi-a='docker rmi $(d images -q)'
alias d-c-down-a='docker-compose down --rmi all -v'

###########################
# tmux
###########################

alias t='tmux'

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

