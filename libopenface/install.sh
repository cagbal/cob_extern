#!/usr/bin/env bash
set -ex

# Make it "0" if you have already Torch, but you need to install
# Torch packages manually
INSTALL_TORCH=1

apt-get update && apt-get install -y \
    build-essential \
    libgraphicsmagick1-dev \
    libatlas-dev \
    python-dev \
    python-pip \
    python-protobuf\ -
    software-properties-common \
    zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

cd ~

if [[ "$INSTALL_TORCH" = 1 ]] ; then
    curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash -e
    git clone https://github.com/torch/distro.git ~/torch --recursive
    cd ~/torch && ./install.sh && \
    cd install/bin && \
    ./luarocks install nn && \
    ./luarocks install dpnn && \
    ./luarocks install image && \
    ./luarocks install optim && \
    ./luarocks install csvigo && \
    ./luarocks install torchx && \
    ./luarocks install tds
fi

echo  'PATH=$PATH\:/root/torch/install/bin ; export PATH' >> ~/.bashrc

echo Installation of dependencies of cob_people_detection completed
