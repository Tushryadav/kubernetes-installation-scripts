#!/bin/bash
#
# Setup for Control Plane (Master) servers

set -euxo pipefail

# If you need public access to API server using the servers Public IP adress, change PUBLIC_IP_ACCESS to true.

PUBLIC_IP_ACCESS="false"
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"

# Pull required images

sudo kubeadm config images pull

if [[ "$PUBLIC_IP_ACCESS" == "false" ]]; then
    # Detect the primary interface
    IFACE=$(ip route show default | awk '{print $5}')

    # Get private IP of the detected interface
    MASTER_PRIVATE_IP=$(ip -4 addr show "$IFACE" | awk '/inet / {print $2}' | cut -d/ -f1)

    echo "Using interface: $IFACE"
    echo "Detected private IP: $MASTER_PRIVATE_IP"

    sudo kubeadm init \
      --apiserver-advertise-address="$MASTER_PRIVATE_IP" \
      --apiserver-cert-extra-sans="$MASTER_PRIVATE_IP" \
      --pod-network-cidr="$POD_CIDR" \
      --node-name "$NODENAME" \
      --ignore-preflight-errors Swap

elif [[ "$PUBLIC_IP_ACCESS" == "true" ]]; then
    MASTER_PUBLIC_IP=$(curl -s ifconfig.me)
    echo "Detected public IP: $MASTER_PUBLIC_IP"

    sudo kubeadm init \
      --control-plane-endpoint="$MASTER_PUBLIC_IP" \
      --apiserver-cert-extra-sans="$MASTER_PUBLIC_IP" \
      --pod-network-cidr="$POD_CIDR" \
      --node-name "$NODENAME" \
      --ignore-preflight-errors Swap

else
    echo "Error: PUBLIC_IP_ACCESS has an invalid value: $PUBLIC_IP_ACCESS"
    exit 1
fi

# Configure kubeconfig

mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config

# Install Claico Network Plugin Network

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
~