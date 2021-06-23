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
#  Repositories
#
#########################################################################################################
RELEASE=$(lsb_release -cs)

sudo rm -rf /etc/apt/sources.list
sudo rm -f  /etc/apt/sources.list.d/*

cat << EOF | sudo tee /etc/apt/sources.list
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${RELEASE} main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${RELEASE}-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${RELEASE}-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ ${RELEASE}-security main restricted universe multiverse
EOF

# i3 & polybar
sudo add-apt-repository -y ppa:kgilmer/speed-ricer

# golang
sudo add-apt-repository -y ppa:longsleep/golang-backports

# emacs27
sudo add-apt-repository -y ppa:kelleyk/emacs

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${RELEASE} stable"

# kitwware
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
sudo apt-add-repository -y "deb https://apt.kitware.com/ubuntu/ ${RELEASE} main"

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#alacritty
sudo add-apt-repository ppa:aslatter/ppa

sudo apt update

#########################################################################################################
#
# install packanges 
#
#########################################################################################################

sudo apt install -y \
    arch-install-scripts \
    alacritty \
    arandr \
    bspwm \
    bspwm \
    cmake \
    code \
    dbus-x11 \
    docker-ce docker-ce-cli containerd.io \
    dunst \
    emacs27 \
    feh \
    flameshot \
    fontconfig \
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    fzf \
    git \
    golang-go \
    ibus-gtk \
    ibus-gtk3 \
    ibus-rime \
    jq \
    polybar \
    qt5ct \
    ripgrep \
    rofi \
    rxvt-unicode \
    sqlite3 \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    tree \
    zsh

sudo usermod -aG docker $USER

#########################################################################################################
#
# config docker
#
# #######################################################################################################

cat > /etc/docker/daemon.json <<EOF
{
        "registry-mirrors":["https://docker.mirrors.ustc.edu.cn","http://hub-mirror.c.163.com"],
        "exec-root":"/work/var/run/docker",
        "data-root":"/work/var/lib/docker",
        "dns": ["10.4.192.27", "8.8.8.8"]
}
EOF

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


## install dotfiles
bash -c "$(curl -sSL https://raw.githubusercontent.com/zhoumingjun/dotfiles/master/.bin/dotfiles-install.sh)"
$HOME/.bin/dotfiles-init-submodules.sh
#########################################################################################################
#
# emacs 
#
#########################################################################################################


# doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
