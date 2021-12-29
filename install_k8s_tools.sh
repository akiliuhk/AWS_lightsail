#! /bin/bash -e

# Install Kubernetes tools (kubectl and helm)
echo "Installing Kubernetes Client Tools - kubectl and helm ..."

curl -sLS https://dl.get-arkade.dev | sh
sudo mv arkade /usr/local/bin/arkade
sudo ln -sf /usr/local/bin/arkade /usr/local/bin/ark

ark get helm
sudo mv $HOME/.arkade/bin/helm /usr/local/bin/

ark get kubectl
sudo mv $HOME/.arkade/bin/kubectl /usr/local/bin/


mkdir -p $HOME/.kube
cp /etc/rancher/rke2/rke2.yaml $HOME/.kube/config
echo 'export KUBECONFIG=~/.kube/config' >>~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc