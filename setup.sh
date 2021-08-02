#!/usr/bin/sh

sed "s/$1/$2/g" "colors/$1.lua" > "colors/$2.lua"
rm "colors/$1.lua"

sed "s/$1/$2/g" "doc/$1.txt" > "doc/$2.txt"
rm "doc/$1.txt"

mv "lua/$1.lua" "lua/$2.lua"

sed "s/$1/$2/g" "README.md" > "README_2.md"
mv "README_2.md" "README.md"

git remote add upstream https://github.com/Iron-E/nvim-highlite.git
git fetch --all

echo "Run 'set rtp+=$(pwd)' from within Vim to include this folder in your runtime path."
echo ""
echo "You must do this before sourcing your colorscheme, unless you are using a plugin manager."
