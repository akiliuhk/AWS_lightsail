#!/bin/bash -ex

export STD=$1

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

