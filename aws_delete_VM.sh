#!/bin/bash -ex

export STD=std01

### delete AWS Lightsail instance
aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rancher --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-m1 --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-w1 --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-w2 --output yaml --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-w3 --output yaml --no-cli-pager
