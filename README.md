# Overview
This repo is following the best practice from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

Attention  
Do not save any sensetive data in your dotfiles.
If you have ever pushed any sensetive data in github . please use the following cmd to remove it from git repo.
 
```bash
# e.g. remove .m2/settings.xml 
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch .m2/settings.xml' \
--prune-empty --tag-name-filter cat -- --all
```

# Usage
## Installation
```bash
bash -c "$(curl -sSL https://raw.githubusercontent.com/zhoumingjun/dotfiles/master/.bin/dotfiles-install.sh)"
$HOME/.bin/dotfiles-init-submodules.sh
```
## Update 3rd modules
```bash
$HOME/.bin/dotfiles-update-submodules.sh
```
# Feature list

## vim
use [minipac](https://github.com/k-takata/minpac) to manage the vim modules 

## zsh
use [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

### custom modules
* login module  
  login the target server form the jump server, and you need not to enter the password every time

  ```bash      
  cp .zsh_custom/plugins/login/login.sh.tmpl .zsh_custom/plugins/login/login.sh     
  # modify it to make it work in your own environment
  ```
  
