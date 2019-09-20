[[ -z "$NODENV_HOME" ]] && export NODENV_HOME="$HOME/.nodenv"

_zsh_nodenv_load() {

    eval "$(nodenv init -)"
}
_zsh_nodenv_load

