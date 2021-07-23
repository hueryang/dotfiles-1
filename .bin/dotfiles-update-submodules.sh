#!/usr/bin/env bash
function dots {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dots submodule update --remote
