#!/usr/bin/env bash

# Göran Gustafsson <gustafsson.g@gmail.com>

rm -rf ~/.vim/backups/bundle
rm -rf ~/.vim/backups/vim-pathogen

mv ~/.vim/vim-pathogen ~/.vim/backups/
cd ~/.vim

git clone git://github.com/tpope/vim-pathogen.git

mv ~/.vim/bundle ~/.vim/backups/
mkdir ~/.vim/bundle
cd ~/.vim/bundle

echo; git clone git://github.com/mattn/gist-vim.git
echo; git clone git://github.com/msanders/snipmate.vim.git
echo; git clone git://github.com/scrooloose/nerdcommenter.git
echo; git clone git://github.com/scrooloose/nerdtree.git
echo; git clone git://github.com/sjbach/lusty.git
echo; git clone git://github.com/tpope/vim-surround.git

date > latest_update.txt
