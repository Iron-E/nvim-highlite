#!/usr/bin/sh

git fetch --all
git checkout upstream/master lua/highlite.lua
mv lua/highlite.lua $(find lua -type f -not -name 'highlite.lua')
