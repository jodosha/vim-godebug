# vim-godebug

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

Copy all files to your ~/.vim directory or use Tim Pope's excellent pathogen plugin (http://github.com/tpope/vim-pathogen).

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
