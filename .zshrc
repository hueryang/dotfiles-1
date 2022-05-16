if [[ -r "$HOME/.config/zi/init.zsh" ]]; then
  source "$HOME/.config/zi/init.zsh" && zzinit
fi

zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes # <- https://z.digitalclouds.dev/ecosystem/annexes
# examples here -> https://z.digitalclouds.dev/docs/gallery/collection
zicompinit # <- https://z.digitalclouds.dev/docs/guides/commands

zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-syntax-highlighting

zi ice atclone'dircolors -b LS_COLORS > clrs.zsh' \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zi light trapd00r/LS_COLORS

zi snippet OMZP::git
zi snippet OMZP::emacs
zi snippet OMZP::asdf

zi snippet 'https://github.com/zhoumingjun/zsh-plugins/blob/master/login/login.plugin.zsh'
zi snippet 'https://github.com/zhoumingjun/zsh-plugins/blob/master/proxy/proxy.plugin.zsh'

eval "$(starship init zsh)"

# alias
alias ls="ls --color=auto"
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# environments
setopt no_nomatch
export WINEARCH=win32
tph-st1
