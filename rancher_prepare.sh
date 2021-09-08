#!/bin/bash -e

function create-bucket(){
local tags=$1
cd ~/$tags-lab-info

ssh -c 
 sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:latest

}

main $1