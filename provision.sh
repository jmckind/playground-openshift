#!/bin/bash

export CLUSTER_IP=$(ip address show dev eth1 | awk 'FNR == 3 {print $2}' | cut -f 1 -d '/')
echo "Installing OpenShift $OPENSHIFT_VERSION using Cluster IP ${CLUSTER_IP}"

# Update the system and install required packages
sudo yum update && sudo yum install -y \
  bc \
  bind-utils \
  bsdtar \
  createrepo \
  file \
  gcc \
  git \
  gitgo \
  gpgme \
  gpgme-devel \
  jq \
  krb5-devel \
  libassuan \
  libassuan-devel \
  make \
  mercurial \
  openssl \
  rsync \
  tito \
  zip

# Install the latest version of golang
curl -s https://mirror.go-repo.io/centos/go-repo.repo | sudo tee /etc/yum.repos.d/go-repo.repo
sudo rpm --import https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO
sudo yum update && sudo yum install -y golang

# Install docker from the official Docker repository
curl -fsSL https://get.docker.com/ | sh

# Enable and start the docker daemon
sudo systemctl enable docker && sudo systemctl start docker

# Configure the Docker daemon with an insecure registry entry.
cat <<EOF | sudo tee /etc/docker/daemon.json
{
   "insecure-registries": [
     "172.30.0.0/16"
   ]
}
EOF

# Reload systemd and restart the Docker daemon
sudo systemctl daemon-reload && sudo systemctl restart docker

# Add the system user to the docker group.
SYSTEM_USER=vagrant
sudo usermod -aG docker ${SYSTEM_USER}

# Clone the configured branch/tag of the openshift origin repository.
git clone -b ${OPENSHIFT_VERSION} https://github.com/openshift/origin.git /home/${SYSTEM_USER}/origin

# Build the oc binary
cd /home/${SYSTEM_USER}/origin
make all WHAT=cmd/oc GOFLAGS=-v
sudo cp _output/local/bin/linux/amd64/oc /usr/bin/
cd /home/${SYSTEM_USER}

# Verify the oc command is working
oc version

# Launch openshift
oc cluster up --enable=*,service-catalog --public-hostname=${CLUSTER_IP}.nip.io --routing-suffix=${CLUSTER_IP}.nip.io
