#!/bin/bash -e

function install_rancher() {
  local tags=$1
  local ip=`aws lightsail get-instance --instance-name $tags-rancher --query 'instance.publicIpAddress' --output text --no-cli-pager`
  cd ~/GitHub/AWS_lightsail

  scp -i ~/$tags-lab-info/$tags-default-key.pem -o StrictHostKeyChecking=no install_rancher.sh ec2-user@$ip:~/install_rancher.sh

  ssh -i ~/$tags-lab-info/$tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip './install_rancher.sh'
}

install_rancher $1