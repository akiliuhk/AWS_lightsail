#!/bin/bash -e

function install_k8s_tools() {
  local tags=$1
  local ip=`aws lightsail get-instance --instance-name $tags-rke-m1 --query 'instance.publicIpAddress' --output text --no-cli-pager`
  cd ~/GitHub/AWS_lightsail

  scp -i ~/$tags-lab-info/$tags-default-key.pem -o StrictHostKeyChecking=no install_k8s_tools.sh ec2-user@$ip:~/install_k8s_tools.sh

  ssh -i ~/$tags-lab-info/$tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip './install_k8s_tools.sh'
}

install_k8s_tools $1