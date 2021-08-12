# Brief
this is a pre-defined aws lightsail bash script to provision AWS Lightsail environment 

## AWS CLI installation 
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

## AWS Lightsail CLI Reference
https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lightsail/index.html#


### Objective
to kick start a Rancher demo environment for workshop.

the script will provision on Singapore ap-southeast-1 with ***medium size (2 CPU,4G RAM,80G SSD)*** and OS ***opensuse_15_2*** also tags key=input namespace 

STD-rancher
STD-rke-m1
STD-rke-w1
STD-rke-w2
STD-rke-w3

### aws_get_vm
```
aws lightsail get-instances --region ap-southeast-1 --query 'instances[].{publicIpAddress:publicIpAddress,privateIpAddress:privateIpAddress,VMname:name}' --output table --no-cli-pager
```
### aws_create_vm
the create-instance 

```
aws lightsail create-instances --region ap-southeast-1 --instance-names  {$STD-rancher,$STD-rke-m1,$STD-rke-w1,$STD-rke-w2,$STD-rke-w3} --availability-zone ap-southeast-1a --blueprint-id opensuse_15_2 --bundle-id medium_2_0 --ip-address-type ipv4 --user-data "systemctl enable docker;systemctl start docker;" --tags key=$STD --no-cli-pager
```
### aws_open_vm_ports
```
### open ports for AWS Lightsail VM
aws lightsail put-instance-public-ports \
--port-infos \
"fromPort=22,toPort=22,protocol=TCP" \
"fromPort=80,toPort=80,protocol=TCP" \
"fromPort=443,toPort=443,protocol=TCP" \
"fromPort=8,toPort=-1,protocol=ICMP" \
--instance-name $STD-rancher --output yaml --no-cli-pager
```
### aws_stop_vm
```
aws lightsail stop-instance --instance-name $STD-rancher --output yaml --no-cli-pager
```
### aws_start
```
aws lightsail start-instance --instance-name $STD-rancher --output yaml --no-cli-pager
```
### aws_delete_vm
```
aws lightsail delete-instance --region ap-southeast-1  --instance-name $STD-rancher --output yaml --no-cli-pager
```


### example to start VM with namespace std01
```
./aws_start_VM.sh std01
```