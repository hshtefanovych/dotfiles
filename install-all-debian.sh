#!/bin/bash

sudo -v

########### Install apps ############
sudo apt install -y git curl wget zip unzip fzf vim

########### Configure git ###########
git config --global user.name "Heorhii Shtefanovych"
git config --global user.email "hshtefanovych@gmail.com"
git config --global core.editor vim
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3

########### Configure Vim ###########
cp .vimrc ~/.vimrc

########### Install bashrc ##########
cp .bashrc ~/.bashrc

