#!/bin/sh

###########################
# mac
###########################
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false       
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false 
defaults delete -g ApplePressAndHoldEnabled                                      
defaults write -g InitialKeyRepeat -int 9
defaults write -g KeyRepeat -int 2

printf "\e[32m[Complete] mac\e[m\n"
