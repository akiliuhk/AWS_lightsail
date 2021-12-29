#!/bin/bash -ex

### delete AWS Lightsail VM
function delete-instance(){

local tags=$1
rm -r ~/$tags-lab-info
rm  ~/$tags-lab-info.tar.gz

aws lightsail delete-key-pair --key-pair-name $tags-default-key --output text --no-cli-pager

aws lightsail delete-bucket --bucket-name $tags-s3-bucket --force-delete --output text --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rancher --output text --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rke-m1 --output text --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rke-w1 --output text --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rke-w2 --output text --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $tags-rke-w3 --output text --no-cli-pager

}

delete-instance $1
