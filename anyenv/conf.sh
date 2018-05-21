#!/bin/sh
if anyenv update | grep "no such command"; then
	mkdir -p $(anyenv root)/plugins
	git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
fi
anyenv update

anyenv init
anyenv install rbenv
anyenv install pyenv
anyenv install nodenv
anyenv install phpenv
exec $SHELL -l



