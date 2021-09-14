#!/bin/bash -e

function install_rancher() {
  local tags=$1
  cd ~/$tags-lab-info
  ip=`cat $tags-get-instances.txt | grep $tags-rancher | cut -d '|' -f 4 | xargs`
  ssh -i $tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip 'sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:latest'
  container=`ssh -i $tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip 'sudo docker ps -q'`
  sleep 180
  ssh -i $tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip "sudo docker logs $container 2>&1 | grep Password:"
}


install_rancher $1