#!/usr/bin/sh
mv "lua/$1.lua" "lua/$2.lua"

sed "s/$1/$2/g" "colors/$1.vim" > "colors/$2.vim"
rm "colors/$1.vim"

echo "Run 'set rtp+=$(pwd)' from within Vim to include this folder in your runtime path."
echo ""
echo "You must do this before sourcing your colorscheme."
