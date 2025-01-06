# Install zsh & oh-my-zsh
sudo pacman -S --noconfirm git zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s $(which zsh)
# Do logout & login

# Upgrade all
sudo pacman -Syyu

sudo pacman -Syu brave-bin kitty dbeaver slack-desktop visual-studio-code-bin go asdf-vm gtk3 gtk4 k9s go-tools git thunar bpytop \
  cpu-x ctop docker docker-buildx docker-compose dust flameshot freedownloadmanager git grep jq kubectl kubectx vim nmap peek rsync \
  systemd yay ssh-tools eza ffmpeg ffmpeg4.4 fzf lsof sbc tree which wget bat yum gnome-disk-utility postman-bin gnome-disk-utility \
  gnome-system-monitor

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

# For Games
sudo pacman -S heroic-games-launcher-bin steam 

# GPU drivers
# sudo pacman -S vulkan-radeon #AMD GPUs
# sudo pacman -S nvidia-utils #nvidia
# sudo pacman -S vulkan-intel #intel

# Add required plugins
asdf plugin-add golang
asdf plugin-add nodejs

# Install k3s 
curl -sfL https://get.k3s.io | sh -

sudo systemctl status k3s
sudo systemctl restart k3s
# Grant necessary permissions
sudo chmod -R 755 /etc/rancher/k3s
sudo chown -R $(whoami):$(whoami) /etc/rancher/k3s
# Ensure Proper kubeconfig
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
# Test kubectl
kubectl get nodes
# Check if API server is running
netstat -tuln | grep 6443
