#!/usr/bin/sh
mv "lua/$1.lua" "lua/$2.lua"

sed "s/$1/$2/g" "colors/$1.vim" > "colors/$2.vim"
rm "colors/$1.vim"
