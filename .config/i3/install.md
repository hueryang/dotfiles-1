# Installation

```bash
# clean existing dotfiles
cd $HOME
rm -rf .dotfiles \
    .bin \
    .config/i3 \
    .config/i3status \
    .config/fcitx/rime \
    .config/ibus/rime \
    .config/conky \
    .config/alacritty \
    .doom.d \
    .jenv \
    .nodenv \
    .oh-my-zsh \
    .hyper.js \
    .pyenv \
    .rbenv \
    .zsh_custom \
    .condarc \
    .gitmodules \
    .hyper.js \
    .npmrc \
    .p10k.zsh \
    .zshrc \
    README.org

# install dotfiles
bash -c "$(curl -sSL https://raw.githubusercontent.com/zhoumingjun/dotfiles/master/.bin/dotfiles-install.sh)"
$HOME/.bin/dotfiles-init-submodules.sh

# download fonts for p10k
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

fc-cache -fv

# enable i3 ppa
sudo add-apt-repository -y ppa:kgilmer/speed-ricer

sudo apt install git \
    arandr \
    dbus-x11 \
    dolphin \
    dunst \
    fcitx-rime \
    firefox \
    flameshot \
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    i3-gaps \
    inxi \
    konsole \
    lxappearance \
    neofetch \
    qt5ct \
    rofi \
    screenfetch \
    tree \
    yakuake \
    zsh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install visual studio code

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code # or code-insiders


# install turbovnc
wget https://astuteinternet.dl.sourceforge.net/project/turbovnc/2.2.5/turbovnc_2.2.5_amd64.deb

sudo dpkg -i turbovnc_2.2.5_amd64.deb
```
