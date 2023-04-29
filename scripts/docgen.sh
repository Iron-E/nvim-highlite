#!/usr/bin/env bash

panvimdoc.sh --project-name highlite \
	--input-file README.md \
	--description 'A colorscheme generator with great defaults' \
	--dedup-subheadings 'false' \
	--demojify false \
	--doc-mapping true \
	--doc-mapping-project-name true \
	--ignore-rawblocks true \
	--increment-heading-level-by 0 \
	--shift-heading-level-by 0 \
	--toc true \
	--treesitter true \
	--vim-version 'Nvim v0.8.0'
