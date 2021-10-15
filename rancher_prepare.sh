#!/bin/bash -e

function install_rancher() {
  local tags=$1
  local ip=`aws lightsail get-instance --instance-name $tags-rancher --query 'instance.publicIpAddress' --output text --no-cli-pager`
  cd ~/$tags-lab-info
  ssh -i $tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip 'sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:latest'
  
  sleep 60
  ssh -i $tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip "sudo docker logs $(sudo docker ps -q) 2>&1 | grep Password:"
}


install_rancher $1