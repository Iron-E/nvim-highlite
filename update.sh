#!/usr/bin/sh

git fetch --all
git checkout upstream/master-v3 lua/highlite/init.lua
mv lua/highlite/init.lua $(find lua -type f -name 'init.lua' -not -path 'lua/highlite/*')
