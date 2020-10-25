mv "lua/$1.lua" "lua/$2.lua"

sed "s/$1/$2/g" "colors/$1.vim" > "colors/$2.vim"
rm "colors/$1.vim"

mkdir ../$2
mv * ../$2

echo "Put the line shown below in init.vim to load your plugin"
echo "call plug#begin(<your plugin manager directorty>)"
echo "Plug '$(pwd)'"
echo "call plug#end()"
