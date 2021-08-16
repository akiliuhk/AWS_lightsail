#!/bin/bash

export STD=$1

### create AWS Lightsail VM
aws lightsail create-instances --region ap-southeast-1 --instance-names  {$STD-rancher,$STD-rke-m1,$STD-rke-w1,$STD-rke-w2,$STD-rke-w3} --availability-zone ap-southeast-1a --blueprint-id opensuse_15_2 --bundle-id medium_2_0 --ip-address-type ipv4 --user-data "systemctl enable docker;systemctl start docker;" --tags key=$STD --no-cli-pager

### sleep 60s to wait AWS Lightsail VM finished provision.
sleep 60;

### open ports for AWS Lightsail VM
aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
"fromPort=8,toPort=-1,protocol=ICMP" \
--instance-name $STD-rancher --output yaml --no-cli-pager

aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
"fromPort=8,toPort=-1,protocol=ICMP" \
--instance-name $STD-rke-m1 --output yaml --no-cli-pager

aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
"fromPort=8,toPort=-1,protocol=ICMP" \
--instance-name $STD-rke-w1 --output yaml --no-cli-pager

aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
"fromPort=8,toPort=-1,protocol=ICMP" \
--instance-name $STD-rke-w2 --output yaml --no-cli-pager

aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
"fromPort=8,toPort=-1,protocol=ICMP" \
--instance-name $STD-rke-w3 --output yaml --no-cli-pager

### download default-key-pair
aws lightsail download-default-key-pair --output text --query publicKeyBase64 > ~/.ssh/lightsail-default-key.pub
chmod 644 ~/.ssh/lightsail-default-key.pub
aws lightsail download-default-key-pair --output text --query privateKeyBase64 > ~/.ssh/lightsail-default-key
chmod 600 ~/.ssh/lightsail-default-key



### get AWS Lightsail instance
aws lightsail get-instances --region ap-southeast-1 --query 'instances[].{publicIpAddress:publicIpAddress,privateIpAddress:privateIpAddress,VMname:name}' --output table --no-cli-pager
