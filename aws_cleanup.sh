#!/bin/bash -ex

### delete AWS Lightsail instance
aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rancher --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-m1 --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-w1 --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-w2 --no-cli-pager

aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rke-w3 --no-cli-pager
