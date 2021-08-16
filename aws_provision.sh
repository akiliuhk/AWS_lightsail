#!/bin/bash

### main function
function main(){
    
local tags=$1

create-instances $tags-rancher $tags-rke-m1 $tags-rke-w1 $tags-rke-w2 $tags-rke-w3 $tags
check-instance-state $tags
put-instance-ports $tags-rancher
put-instance-ports $tags-rke-m1
put-instance-ports $tags-rke-w1
put-instance-ports $tags-rke-w2
put-instance-ports $tags-rke-w3
#download-key
get-instances
ssh-file $tags $tags-rancher
ssh-file $tags $tags-rke-m1
ssh-file $tags $tags-rke-w1
ssh-file $tags $tags-rke-w2
ssh-file $tags $tags-rke-w3
}

### create AWS Lightsail VM
function create-instances(){
local VMname1=$1
local VMname2=$2
local VMname3=$3
local VMname4=$4
local VMname5=$5
local tags=$6

aws lightsail create-instances \
    --region ap-southeast-1 \
    --instance-names {"$VMname1","$VMname2","$VMname3","$VMname4","$VMname5"} \
    --availability-zone ap-southeast-1a \
    --blueprint-id opensuse_15_2 \
    --bundle-id nano_2_0 \
    --ip-address-type ipv4 \
    --user-data "systemctl enable docker;systemctl start docker;" \
    --tags key=$tags --no-cli-pager | grep status
}

### chekc if VM provision
function check-instance-state(){
local $tags=$1
mkdir -p ~/$1-lab-info/
sleep 10
get-instances > ~/$1-lab-info/$1-get-instances.txt
while :
do
  if grep -q pending ~/$1-lab-info//$1-get-instances.txt
  then
    echo 'pending VM provisioning...'
    get-instances > ~/$1-lab-info/$1-get-instances.txt
    sleep 5
  else
    echo 'all VM is up and running'
    get-instances > ~/$1-lab-info/$1-get-instances.txt
    break
  fi
done
}

### open ports for AWS Lightsail VM
function put-instance-ports(){

local VMname=$1

aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
"fromPort=8,toPort=-1,protocol=ICMP" \
--instance-name $VMname --output yaml --no-cli-pager | grep status
}

### download default-key-pair

function download-key(){
aws lightsail download-default-key-pair --output text --query publicKeyBase64 > ~/$1-lab-info//lightsail-default-key.pub
chmod 644 ~/$1-lab-info/lightsail-default-key.pub
aws lightsail download-default-key-pair --output text --query privateKeyBase64 > ~/$1-lab-info//lightsail-default-key.pem
chmod 600 ~/$1-lab-info//lightsail-default-key.pem
}

### get AWS Lightsail instance
function get-instances(){
aws lightsail get-instances --region ap-southeast-1 \
    --query 'instances[].{publicIpAddress:publicIpAddress,privateIpAddress:privateIpAddress,VMname:name,state:state.name}' \
    --output table --no-cli-pager
}

### ssh command into file
function ssh-file(){
local ip=`aws lightsail get-instance --instance-name $2 --query instance.publicIpAddress --no-cli-pager`
    echo 'ssh -i ~/$1-lab-info//lightsail-default-key.pem -o StrictHostKeyChecking=no ec2-user@'$ip > ~/$1-lab-info/ssh-$2.sh
    chmod 755 ~/$1-lab-info/ssh-$2.sh                   
}

main $1
