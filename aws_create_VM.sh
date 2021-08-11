#!/bin/bash -ex

export STD=std01

aws lightsail create-instances --region ap-southeast-1 --instance-names  {$STD-rancher,$STD-rke-m1,$STD-rke-w1,$STD-rke-w2,$STD-rke-w3} --availability-zone ap-southeast-1a --blueprint-id opensuse_15_2 --bundle-id medium_2_0 --ip-address-type ipv4 --user-data "systemctl enable docker;systemctl start docker;" --tags key=$STD --no-cli-pager


