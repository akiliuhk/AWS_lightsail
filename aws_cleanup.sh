#!/bin/bash -ex

export STD=$1

### delete AWS Lightsail VM
aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rancher --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-m1 --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-w1 --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-w2 --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-w3 --output yaml --no-cli-pager

aws lightsail delete-key-pair --key-pair-name $1-default-key --output yaml --no-cli-pager

rm -fr ~/$1-lab-info/