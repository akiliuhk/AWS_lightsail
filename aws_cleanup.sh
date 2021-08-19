#!/bin/bash -ex

### delete AWS Lightsail VM
function delete-instance(){

local tags=$1
rm -fr ~/$tags-lab-info/
aws lightsail delete-key-pair --key-pair-name $tags-default-key --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rancher --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rke-m1 --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rke-w1 --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rke-w2 --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rke-w3 --output yaml --no-cli-pager
}

delete-instance $1
