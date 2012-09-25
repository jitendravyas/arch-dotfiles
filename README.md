# Arch Dotfiles

These are the the bootstrap ‘dotfiles’ I use on all of my Arch Linux boxes. I've kept it clean and simple with only the configs for Vim, Bash and Git included at the moment.

## Installation

This repository sits in my home directory, there's no install scripts or symlinking. This comes from [Ryan Tomayko's](https://github.com/rtomayko/dotfiles) technique of installing dotfiles. This **will** overwrite any existing dot files.

```bash
cd
git clone git@github.com:Matt-Stevens/arch-dotfiles.git
mv arch-dotfiles/* arch-dotfiles/.* ./ && rm -rf ./arch-dotfiles
echo "*" > ~/.git/info/exclude
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
. ~/.bashrc
```
