#!/bin/bash -ex

export STD=std01

aws lightsail create-instances --region ap-southeast-1 --instance-names  {$STD-rancher,$STD-rke-m1,$STD-rke-w1,$STD-rke-w2,$STD-rke-w3} --availability-zone ap-southeast-1a --blueprint-id opensuse_15_2 --bundle-id medium_2_0 --ip-address-type ipv4 --user-data "systemctl enable docker;systemctl start docker;" --tags key=$STD --no-cli-pager


aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
fromPort=8,toPort=-1,protocol=ICMP \
--instance-name $STD-rancher --no-cli-pager

aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
fromPort=8,toPort=-1,protocol=ICMP \
--instance-name $STD-rke-m1 --no-cli-pager

aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
fromPort=8,toPort=-1,protocol=ICMP \
--instance-name $STD-rke-w1 --no-cli-pager

aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
fromPort=8,toPort=-1,protocol=ICMP \
--instance-name $STD-rke-w2 --no-cli-pager

aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
fromPort=8,toPort=-1,protocol=ICMP \
--instance-name $STD-rke-w3 --no-cli-pager

