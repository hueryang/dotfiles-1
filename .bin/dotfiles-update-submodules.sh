#!/usr/bin/env bash
function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dotfiles submodule update --recursive --remote
