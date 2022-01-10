# config
Own configuration file repository
```sh
mv ./config/.* ~/
```

# startup installations

## docker
install docker (https://docs.docker.com/engine/install/ubuntu/)
```sh
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Then install docker-nvidia (https://nvidia.github.io/nvidia-docker/)
```sh
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
```
maybe easier way here: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)

```sh
sudo usermod -aG docker $USER
```

docker pull oldest version which uses cuda 11.1 
```sh
# https://hub.docker.com/r/nvidia/cuda
docker pull nvidia/cuda:11.1-devel-ubuntu18.04
# https://hub.docker.com/r/pytorch/pytorch
docker pull pytorch/pytorch:1.9.1-cuda11.1-cudnn8-devel
# https://hub.docker.com/r/tensorflow/tensorflow
docker pull tensorflow/tensorflow:2.5.1-gpu
```

## nvidia-driver
install from grahics-drivers.
https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa
```sh
sudo lshw -C display
ubuntu-drivers devices
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt-get install nvidia-driver-470
sudo reboot
```

## driver + cuda toolkit
install driver from offical nvidia repository.
https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html#ubuntu-lts
```sh
sudo apt-get install linux-headers-$(uname -r)
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
sudo apt-get update
sudo apt-get -y install cuda-drivers
```

## Try this First!!! (This installs nvidia-driver + cuda)
download here https://developer.nvidia.com/cuda-toolkit-archive (You can also find installation guide here!)
and follow instruction here
https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#ubuntu-installation
```sh
sudo dpkg -i cuda-repo-<distro>_<version>_<architecture>.deb
sudo apt-key add /var/cuda-repo-<distro>-<version>/7fa2af80.pub
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/<distro>/<architecture>/7fa2af80.pub
wget https://developer.download.nvidia.com/compute/cuda/repos/<distro>/<architecture>/cuda-<distro>.pin
sudo mv cuda-<distro>.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-get update
sudo apt-get install cuda
sudo apt-get install nvidia-gds 
```

post installation actions (https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions)
```sh
export PATH=/usr/local/cuda-11.5/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-11.5/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
sudo systemctl enable nvidia-persistenced
# find more at the link above
```

## gpustat
https://github.com/wookayin/gpustat

```sh
pip3 install git+https://github.com/wookayin/gpustat.git@master
```
Should add bin file pwd to the path


## fzf
https://github.com/junegunn/fzf
```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## bashmarks
https://github.com/huyng/bashmarks
```sh
git clone git://github.com/huyng/bashmarks.git
cd bashmarks
make install
```

## algo
https://github.com/trailofbits/algo/blob/master/docs/client-linux-wireguard.md

```sh
# Update your system:
sudo apt update && sudo apt upgrade

# If the file /var/run/reboot-required exists then reboot:
[ -e /var/run/reboot-required ] && sudo reboot

# Install WireGuard:
sudo apt install wireguard openresolv
```
```sh
# Install the config file to the WireGuard configuration directory on your
# Linux client:
sudo install -o root -g root -m 600 <username>.conf /etc/wireguard/wg0.conf

# Start the WireGuard VPN:
sudo systemctl start wg-quick@wg0

# Check that it started properly:
sudo systemctl status wg-quick@wg0

# Verify the connection to the AlgoVPN:
sudo wg

# See that your client is using the IP address of your AlgoVPN:
curl ipv4.icanhazip.com

# Optionally configure the connection to come up at boot time:
sudo systemctl enable wg-quick@wg0
```

```
[Interface] 
PrivateKey = * 
Address = 10.19.49.99
DNS = 172.?.?.?
 
[Peer] 
PublicKey = * 
PresharedKey = * 
AllowedIPs = 10.19.49.0/24, 114.71.0.0/16 
Endpoint = *
PersistentKeepalive = 25 
```

## etc (apt install stuffs)
```sh
sudo apt update
sudo apt install \
    iftop \
    vim \
    net-tools \
    tig
```


.
