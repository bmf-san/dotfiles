#!/bin/sh
anyenv init
anyenv install rbenv
anyenv install pyenv
anyenv install nodenv
anyenv install phpenv
exec $SHELL -l

