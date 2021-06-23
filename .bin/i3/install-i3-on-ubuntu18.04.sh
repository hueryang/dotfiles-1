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

# i3-gaps
sudo add-apt-repository -y ppa:kgilmer/speed-ricer

# golang
sudo add-apt-repository -y ppa:longsleep/golang-backports

# emacs26
sudo add-apt-repository -y ppa:kelleyk/emacs

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${RELEASE} stable"

# kitwware
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
sudo apt-add-repository -y "deb https://apt.kitware.com/ubuntu/ ${RELEASE} main"

# chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

sudo apt update

#########################################################################################################
#
# install packanges 
#
#########################################################################################################

sudo apt install -y \
    arandr \
    arch-install-scripts \
    breeze \
    cmake \
    code \
    dbus-x11 \
    default-jdk \
    docker-ce docker-ce-cli containerd.io \
    dolphin \
    dunst \
    editorconfig \
    emacs26 \
    feh \
    firefox \
    flameshot \
    fontconfig \
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    git \
    golang-go \
    google-chrome-stable \
    graphviz \
    i3-gaps \
    ibus-gtk \
    ibus-gtk3 \
    ibus-rime \
    inxi \
    libtool \
    libtool-bin \
    jq \
    konsole \
    kubectl \
    lxappearance \
    markdown \
    neofetch \
    qt5ct \
    rofi \
    rxvt-unicode \
    screenfetch \
    shellcheck \
    sqlite3 \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    tree \
    yakuake \
    zsh 

wget https://github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb -P ~/tmp/
wget https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb -P ~/tmp/
 
sudo apt install -y  ~/tmp/*.deb
sudo usermod -aG docker $USER 

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


#########################################################################################################
#
# configuration
#
#########################################################################################################

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

# node-build
mkdir -p "$(nodenv root)"/plugins
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

# ruby-build
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

#########################################################################################################
#
# emacs 
#
#########################################################################################################


# doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
