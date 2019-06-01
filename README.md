# Vim-RNB, a Vim colorscheme template

## What is this thing?

RNB is a template designed to help vimmers create their own colorschemes without much effort.

In reality, Vim colorschemes are not that hard to write but there are several benefits to using a template such as RNB:

* you can define/modify variables once instead of messing around with potentially botched substitutions,
* you can distribute a lean colorscheme, free from unnecessary logic,
* you can distribute the source alongside the colorscheme, making it easy for your users to experiment and adapt *your* colorschemes to *their* needs,
* you can focus on the design of your colorscheme rather than its implementation,
* you can start working on new colorscheme ideas very easily.

## What do I need to use it?

[ERB](https://ruby-doc.org/stdlib-2.6.3/libdoc/erb/rdoc/index.html), the templating engine used here, is part of Ruby's standard library so you will need [Ruby](https://www.ruby-lang.org/) to generate your colorscheme. Neither ERB nor Ruby knowledge is required, though.

## How do I use it?

The process is divided in five steps:

1. rename `colors/rnb.erb` to `colors/name_of_your_colorscheme.erb`,
2. start by editing your colorscheme's information,
3. define your colors,
4. define your highlight groups and links,
5. and generate your colorscheme.

Each step is thoroughly described in the colorscheme template itself in an effort to make it portable: if you ever decide to distribute your colorscheme you can simply package the template with it.

## TODO

* `README.md` template


[//]: # ( Vim: set spell spelllang=en: )
