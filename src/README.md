# rnb

Lorem ipsum dolor sit amet.

## Requirements

This colorscheme should be accepted by any Vim build or version on any platform without throwing any error but it is specifically designed with the following environments in mind…

### GUI Vim (GVim, MacVim)

The colorscheme should work without any user intervention.

### Color terminals capable of displaying "true colors"

If your terminal emulator is capable of displaying "true colors" and set up to do so, you can tell Vim to use the colorscheme's GUI-specific color definitions instead of those specific to color terminals.

Check your terminal emulator's documentation to see if it supports "true colors" and Vim's `:help xterm-true-color` for additional information.

### Color terminals capable of displaying 256 colors

### Color terminals capable of displaying 16 colors

### Color terminals capable of displaying 8 colors

## Installation

### With a plugin manager

Follow your plugin manager's instructions.

### Manually

Move `colors/foobar-baz.vim` to:

* `$HOME/.vim/colors/foobar-bazvim` on UNIX-like systems,
* `$HOME\vimfiles\colors\foobar-bazvim` on Windows.

## Activation

Add the line below to your `vimrc`:

    colorscheme foobar-baz

and either reload your `vimrc`:

    :source $MYVIMRC

or start a new Vim session.

NOTE: if you installed foobar-baz with the help of a plugin manager, make sure that line comes *after* any line related in one way or another to your plugin manager.

## Hacking

## Acknowledgements
