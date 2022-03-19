# vim-GoDebug

Go debugging for Vim.

## See it in action

![vim-godebug](https://github.com/jodosha/vim-go-debug/raw/master/vim-godebug.gif)

## Prerequisites

    * Go
    * [Neovim](https://neovim.io/)
    * [vim-go](https://github.com/fatih/vim-go)
    * [Delve](https://github.com/derekparker/delve)
    * On macOS, it is advised to install through [brew](https://github.com/derekparker/delve/blob/master/Documentation/installation/osx/install.md#via-homebrew), due to problems with certificates.

## Installation

Godebug follows the standard runtime path structure. There are some helper lines for your _vim/nvim_ for popular plugin managers.

* [Vim 8 packages](http://vimhelp.appspot.com/repeat.txt.html#packages)
  * `git clone https://github.com/jodosha/vim-godebug.git ~/.vim/pack/plugins/start/vim-go`
* [Neovim packages](https://neovim.io/doc/user/repeat.html#packages)
* `git clone https://github.com/jodosha/vim-godebug.git ~/.local/share/nvim/site/pack/plugins/start/vim-go`
* [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone https://github.com/jodosha/vim-godebug.git ~/.vim/bundle/vim-go`
* [vim-plug](https://github.com/junegunn/vim-plug)
    *  `Plug 'jodosha/vim-godebug'`
* [Vundle](https://github.com/VundleVim/Vundle.vim)
  * `Plugin 'jodosha/vim-godebug'`

## Usage

`:call GoToggleBreakpoint()` to add or remove a breakpoint at the current line
`:call GoDebug()` to start a debug session for the main package

## Development and Improvements

This is a tool that is useful for **my workflow**.
If you think it's useful, be my guest and use it too.

I won't actively support this plugin. If you find a bug, or want an improvement, please open a PR if you want to see it fixed.

## Troubleshooting

### Error detected while processing function godebug#debug
**vim** is not yet supported. Try it with **neovim**.

## Copyright

2017 - Luca Guidi - https://lucaguidi.com
