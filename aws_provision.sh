#!/bin/bash

### get AWS Lightsail bundles
#aws lightsail get-bundles --region ap-southeast-1 --query 'bundles[].{price:price,cpuCount:cpuCount,ramSizeInGb:ramSizeInGb,diskSizeInGb:diskSizeInGb,bundleId:bundleId,instanceType:instanceType,supportedPlatforms:supportedPlatforms[0]}' --output table  --no-cli-pager

### get AWS lightsail blueprint
#aws lightsail get-blueprints --region ap-southeast-1 --query 'blueprints[].{blueprintId:blueprintId,name:name,group:group,productUrl:productUrl,platform:platform}' --output table --no-cli-pager

### main function
function main(){
local tags=$1
create-key-pair $tags
create-instances $tags-rancher $tags
create-instances $tags-rke-m1 $tags
create-instances $tags-rke-w1 $tags
create-instances $tags-rke-w2 $tags
create-instances $tags-rke-w3 $tags
check-instance-state $tags
put-instance-ports $tags-rancher
put-instance-ports $tags-rke-m1
put-instance-ports $tags-rke-w1
put-instance-ports $tags-rke-w2
put-instance-ports $tags-rke-w3
create-bucket $tags
ssh-file $tags $tags-rancher
ssh-file $tags $tags-rke-m1
ssh-file $tags $tags-rke-w1
ssh-file $tags $tags-rke-w2
ssh-file $tags $tags-rke-w3
html-file $tags $tags-rancher 80
html-file $tags $tags-rke-w1 30080
html-file $tags $tags-rke-w1 31080
tar-file $tags
}


### create key pair for each $tag 
function create-key-pair (){
local tags=$1
mkdir -p ~/$1-lab-info/
aws lightsail create-key-pair --key-pair-name $tags-default-key --output text --query privateKeyBase64 > ~/$tags-lab-info/$tags-default-key.pem
chmod 600 ~/$tags-lab-info/$tags-default-key.pem

#aws lightsail download-default-key-pair --output text --query publicKeyBase64 > ~/$1-lab-info/$1-default-key.pub
#aws lightsail download-default-key-pair --output text --query privateKeyBase64 > ~/$1-lab-info/$1-default-key.pem
}

### create AWS Lightsail VM
function create-instances(){
local VMname=$1
local tags=$2
aws lightsail create-instances \
  --region ap-southeast-1 \
  --instance-names $VMname \
  --availability-zone ap-southeast-1a \
  --blueprint-id opensuse_15_2 \
  --bundle-id medium_2_0 \
  --ip-address-type ipv4 \
  --key-pair-name $tags-default-key \
  --user-data "systemctl enable docker;systemctl start docker;hostnamectl set-hostname $VMname;" \
  --tags key=$tags \
  --output table \
  --no-cli-pager
}
#   --bundle-id nano_2_0 \
#   --bundle-id medium_2_0 \

### chekc if VM provision
function check-instance-state(){
local $tags=$1
mkdir -p ~/$1-lab-info/
sleep 10
get-instances $tags
while :
do
  if grep -q pending ~/$tags-lab-info/$tags-get-instances.txt
  then
    echo 'pending VM provisioning...'
    get-instances $tags
    sleep 5
  else
    echo 'all VM is up and running'
    get-instances $tags
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
"fromPort=6443,toPort=6443,protocol=TCP" \
"fromPort=30000,toPort=32767,protocol=TCP" \
"fromPort=8,toPort=-1,protocol=ICMP" \
--instance-name $VMname --output table --no-cli-pager
}


### get AWS Lightsail instance
function get-instances(){
local tags=$1
aws lightsail get-instances --region ap-southeast-1 \
--query "instances[].{$tags:name,publicIpAddress:publicIpAddress,privateIpAddress:privateIpAddress,state:state.name}" \
--output table --no-cli-pager | grep $tags > ~/$tags-lab-info/$tags-get-instances.txt

}

### ssh command into file
function ssh-file(){
local tags=$1
local VMname=$2
local ip=`aws lightsail get-instance --instance-name $VMname --query 'instance.publicIpAddress' --output text --no-cli-pager`
echo "ssh -i ~/$tags-lab-info/$tags-default-key.pem -o StrictHostKeyChecking=no ec2-user@"$ip > ~/$tags-lab-info/ssh-$VMname.sh
chmod 755 ~/$tags-lab-info/ssh-$VMname.sh
}

### ssh command into file
function html-file(){
local tags=$1
local VMname=$2
local port=$3
local ip=`aws lightsail get-instance --instance-name $VMname --query 'instance.publicIpAddress' --output text --no-cli-pager`

cd ~/$tags-lab-info

cat > "$VMname-port-$port.html" << EOF
<html>
<head>
<meta http-equiv="refresh" content="0; url=http://$ip:$port" />
</head>
</html>
EOF

}

### tar lab folder
function tar-file(){
local tags=$1
cd ~
tar -cvzf $tags-lab-info.tar.gz $tags-lab-info
}


function create-bucket(){
local tags=$1
cd ~
aws lightsail create-bucket \
  --bucket-name $tags-s3-bucket \
  --bundle-id small_1_0 \
  --output table \
  --no-cli-pager > ~/$tags-lab-info/$tags-s3-bucket.txt

sed -i "" '16,$d'  ~/$tags-lab-info/$tags-s3-bucket.txt

aws lightsail create-bucket-access-key \
  --bucket-name $tags-s3-bucket \
  --output table \
  --no-cli-pager > ~/$tags-lab-info/$tags-s3-bucket-accessKeys.txt
  
sed -i "" '11,$d'  ~/$tags-lab-info/$tags-s3-bucket-accessKeys.txt
}

main $1
