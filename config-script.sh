#!/bin/bash

echo -e "Usage Guide : bash -c 'source config-script.sh; <function-name>'\nWhere function options are: <install-packages> , <set-theme> , <get-plugin> , and <run-all> to accomplish all "

run-all () {

install-packages && set-theme && get-plugin

}

#Install Packages

install-packages () {

sudo apt update

sudo apt install git-all

sudo apt install vim

sudo apt install python3 python3-pip

sudo apt install apache2

}

#Customize Vim & Set Default Theme

set-theme () {

cd ~/.vim && git clone https://github.com/flazz/vim-colorschemes.git

cp -r ~/.vim/vim-colorschemes/colors ~/.vim

echo 'colorscheme moriarty' > ~/.vimrc

}

#Install Vim-Plug + NERDTree & Configure

get-plugin () {

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ~/.vim && git clone https://github.com/preservim/nerdtree.git

echo -e "call plug#begin()\nPlug 'scrooloose/nerdtree'\ncall plug#end()" >> ~/.vimrc

vim -c "PlugInstall" -c q && cd ~

vim -c "NERDTree" -c q -c q

}
