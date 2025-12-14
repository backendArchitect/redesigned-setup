# Install zsh & oh-my-zsh
sudo pacman -S --noconfirm git zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s $(which zsh)
# Do logout & login

# Upgrade all
sudo pacman -Syyu

sudo pacman -Syu brave-bin kitty dbeaver slack-desktop visual-studio-code-bin go asdf-vm gtk3 gtk4 k9s go-tools git thunar bpytop \
  cpu-x ctop docker docker-buildx docker-compose dust flameshot freedownloadmanager git grep jq kubectl kubectx vim nmap peek rsync \
  systemd yay ssh-tools eza ffmpeg ffmpeg4.4 fzf lsof sbc tree which wget bat gnome-disk-utility postman-bin gnome-disk-utility \
  gnome-system-monitor golangci-lint helm wine-stable openssl-1.0 openssl-1.1

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

# For multi org setup tool
go install github.com/gabrie30/ghorg@latest
go install github.com/bufbuild/buf/cmd/buf@v1.13.1
go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v2.13.0
go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v2.13.0
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.1
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2.0
go install github.com/sorcererxw/protoc-gen-go-grpc-mock@v1.1.0
go install github.com/envoyproxy/protoc-gen-validate@v0.9.0
go install github.com/srikrsna/protoc-gen-gotag@v1.0.2
go install github.com/pressly/goose/v3/cmd/goose@latest
git clone git@github.com:fluidtruck/fctl.git
cd fctl && go install

#Google Cloud
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
tar -xf google-cloud-cli-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
#If want to login
#gcloud auth login
#gcloud config set project <project-name>
#gcloud components update
#gcloud components install gke-gcloud-auth-plugin
#gcloud container clusters list
#gcloud container clusters get-credentials <name> --region <region-name>

#fingerprint setup docs https://community.frame.work/t/guide-solved-sudo-and-login-with-fingerprint-reader-under-kde-arch-linux/37009/14

#Add battery threshold service.
sudo vim /etc/systemd/system/battery-charge-threshold.service
```
[Unit]
  Description=Set battery charge thresholds
  After=multi-user.target
  StartLimitBurst=0
  
  [Service]
  Type=oneshot
  Restart=on-failure
  ExecStart=/bin/bash -c 'echo 85 > /sys/class/power_supply/BAT0/charge_control_end_threshold'
  ExecStart=/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_start_threshold'
  
  [Install]
  WantedBy=multi-user.target
```
sudo systemctl enable battery-charge-threshold.service
sudo systemctl start battery-charge-threshold.service
sudo systemctl daemon-reload
sudo systemctl status battery-charge-threshold.service
