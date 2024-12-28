# Install zsh & oh-my-zsh
sudo pacman -S --noconfirm git zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s $(which zsh)
# Do logout & login

# Upgrade all
sudo pacman -Syyu

sudo pacman -Syu brave-bin kitty dbeaver slack-desktop visual-studio-code-bin go asdf-vm gtk3 gtk4 k9s go-tools git thunar bpytop \
  cpu-x ctop docker docker-buildx docker-compose dust flameshot freedownloadmanager git grep jq kubectl kubectx vim nmap peek rsync \
  systemd yay ssh-tools eza ffmpeg ffmpeg4.4 fzf lsof sbc tree which wget bat yum gnome-disk-utility postman-bin

# Enable docker without sudo
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo systemctl enable docker
sudo systemctl start docker
newgrp docker

# Gnome settings
# gsettings set org.gnome.desktop.interface clock-show-date true
# gsettings set org.gnome.shell enabled-extensions 'elementary'
# gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

