#!/usr/bin/env zsh

if [[ -e "$HOME/.zsh_custom/plugins/login/login.zsh" ]] ; then
  alias lg="$HOME/.zsh_custom/plugins/login/login.zsh"
fi

if [[ -e "$HOME/.zsh_custom/plugins/login/login-proxy.zsh" ]] ; then
  alias lgp="$HOME/.zsh_custom/plugins/login/login-proxy.zsh"
fi

