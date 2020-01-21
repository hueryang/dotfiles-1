if [[ -e "$HOME/.zsh_custom/plugins/login/gauth.sh" ]] ; then
  source "$HOME/.zsh_custom/plugins/login/gauth.sh" 
fi
if [[ -e "$HOME/.zsh_custom/plugins/login/login.sh" ]] ; then
  alias lg="$HOME/.zsh_custom/plugins/login/login.sh"
fi
