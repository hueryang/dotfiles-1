# loader
if [[ -r "$HOME/.config/zi/init.zsh" ]]; then
  source "$HOME/.config/zi/init.zsh" && zzinit
fi


# zi
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes # <- https://z.digitalclouds.dev/ecosystem/annexes
# examples here -> https://z.digitalclouds.dev/docs/gallery/collection
zicompinit # <- https://z.digitalclouds.dev/docs/guides/commands

zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-syntax-highlighting

zi snippet OMZL::clipboard.zsh
zi snippet OMZL::compfix.zsh
zi snippet OMZL::completion.zsh
zi snippet OMZL::correction.zsh
zi snippet OMZL::directories.zsh
zi snippet OMZL::functions.zsh
zi snippet OMZL::git.zsh
zi snippet OMZL::grep.zsh
zi snippet OMZL::history.zsh
zi snippet OMZL::key-bindings.zsh
zi snippet OMZL::misc.zsh
zi snippet OMZL::termsupport.zsh


zi ice svn
zi snippet OMZP::emacs
zi snippet OMZP::git
zi snippet OMZP::asdf
zi snippet OMZP::kubectl
zi snippet OMZP::autojump


zi snippet 'https://github.com/zhoumingjun/zsh-plugins/blob/master/login/login.plugin.zsh'
zi snippet 'https://github.com/zhoumingjun/zsh-plugins/blob/master/proxy/proxy.plugin.zsh'



# prompt
eval "$(starship init zsh)"

# alias
alias ls="ls --color=auto"
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# environments
setopt no_nomatch
export WINEARCH=win32
tph-st1
