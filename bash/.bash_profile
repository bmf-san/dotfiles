. ~/.bashrc

if [ -e ~/my_script.sh ]; then
  . ~/my_script.sh
fi

export LC_ALL=en_US.UTF-8
export BASH_SILENCE_DEPRECATION_WARNING=1
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

# alias
alias cd-localdev='cd ${HOME}/localdev'

# git-prompt
if [ -f $HOME/git-prompt.sh ]; then
    source $HOME/git-prompt.sh
fi

# git-completion
if [ -f $HOME/git-completion.bash ]; then
    source $HOME/git-completion.bash
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# go
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)

# anyenv
eval "$(anyenv init -)"
