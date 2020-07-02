#!/usr/bin/env bash
set -euo pipefail

#########################################################################################################
#
# upgrade system 
#
#########################################################################################################

sudo apt update
sudo apt upgrade -y
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    gnupg-agent \
    software-properties-common
#########################################################################################################
#
# configuration file 
#
#########################################################################################################

# .vnc/xstartup
mkdir -p ~/.vnc
cat << EOF > ~/.vnc/xstartup
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
XDG_SESSION_TYPE=x11;  export XDG_SESSION_TYPE

[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid black

#Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1

export GTK_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx
export QT_QPA_PLATFORMTHEME="qt5ct"

vncconfig -nowin &
i3 &
EOF

# /etc/docker/daemon.json
sudo mkdir -p /etc/docker/
cat << EOF | sudo tee /etc/docker/daemon.json
{
        "exec-root":"/work/var/run/docker",
        "data-root":"/work/var/lib/docker"
}
EOF

#########################################################################################################
#
#  Repositories
#
#########################################################################################################

# i3-gaps
sudo add-apt-repository -y ppa:kgilmer/speed-ricer
# golang
sudo add-apt-repository -y ppa:longsleep/golang-backports
# emacs26
sudo add-apt-repository -y ppa:kelleyk/emacs
# docker

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
# chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update

#########################################################################################################
#
# install packanges 
#
#########################################################################################################

sudo apt install -y \
    arch-install-scripts \
    git \
    arandr \
    breeze \
    code \
    dbus-x11 \
    default-jdk \
    dolphin \
    dunst \
    emacs26 \
    feh \
    firefox \
    flameshot \
    fontconfig \
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    golang-go \
    google-chrome-stable \
    i3-gaps \
    ibus-gtk \
    ibus-gtk3 \
    ibus-rime \
    inxi \
    konsole \
    lxappearance \
    neofetch \
    qt5ct \
    rofi \
    screenfetch \
    shellcheck \
    markdown \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    tree \
    yakuake \
    docker-ce docker-ce-cli containerd.io \
    zsh 

wget https://github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb -P ~/tmp/
wget https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb -P ~/tmp/
 
sudo apt install -y  ~/tmp/*.deb
sudo usermod -aG docker $USER 

#########################################################################################################
#
# configuration
#
#########################################################################################################

# install dotfiles
bash -c "$(curl -sSL https://raw.githubusercontent.com/zhoumingjun/dotfiles/master/.bin/dotfiles-install.sh)"
$HOME/.bin/dotfiles-init-submodules.sh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

# node-build
mkdir -p "$(nodenv root)"/plugins
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

# doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install


#########################################################################################################
#
# fonts
#
# #######################################################################################################
# download fonts for p10k

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf 
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf


wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/IBMPlexMono.zip

unzip JetBrainsMono.zip
unzip IBMPlexMono.zip

fc-cache -fv

cd ~


