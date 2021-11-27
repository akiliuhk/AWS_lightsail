#!/bin/bash -e

function install_rancher() {
  local tags=$1
  local ip=`aws lightsail get-instance --instance-name $tags-rancher --query 'instance.publicIpAddress' --output text --no-cli-pager`
  cd ~/GitHub/AWS_lightsail
#ssh -i $tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip 'sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:latest'
#container=`ssh -i $tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip 'sudo docker ps -q'`
 
  scp -i ~/$tags-lab-info/$tags-default-key.pem  install_rancher.sh ec2-user@$ip:~/install_rancher.sh

  export RANCHER_FQDN=rancher.$ip.sslip.io

  ssh -i ~/$tags-lab-info/$tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@$ip './install_rancher.sh'
}


install_rancher $1