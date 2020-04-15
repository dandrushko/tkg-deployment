#!/bin/bash
KUBECTL_VERSION=1.17.3
TKG_CLI_ARCHIVE=tkg-linux-amd64-v1.0.0_vmware.1.gz
TKG_CLI_BINARY=${TKG_CLI_ARCHIVE%.*}

# Tuning host OS to forward requests to localhost
sudo sysctl -w net.ipv4.conf.all.route_localnet=1
sudo iptables -t nat -A PREROUTING -p tcp -m tcp --dport 8080 -j DNAT --to-destination 127.0.0.1:8080
# Preparing fresh Ubuntu host for tkg deployment
sudo apt -y update && apt -y upgrade
# Installing Docker and kubectl dependencies
sudo apt -y install docker.io

sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin
# Unpacking tkg CLI, assuming its in the home folder
gunzip ~/${TKG_CLI_ARCHIVE}; chmod +x ~/${TKG_CLI_BINARY}; sudo mv ~/${TKG_CLI_BINARY} /usr/local/bin/tkg


