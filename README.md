# Brief
this is a pre-defined aws lightsail bash script to provision AWS Lightsail environment 

## AWS CLI installation 
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

### AWS CLI configure credentials
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html 

## AWS Lightsail CLI Reference
https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lightsail/index.html#


## Objective
to kick start a Rancher demo environment for workshop.

the script will provision 5 VM on Singapore ap-southeast-1 with ***medium size (2 CPU,4G RAM,80G SSD)*** and ***opensuse_15_2*** also tags namespace 

## pre-defined AWS Lightsail VM naming convention

for example to run `./aws_create_vm.sh std01`

you will see AWS Lightsail started 5 VM with the input namespace std01

std01-rancher \
std01-rke-m1 \
std01-rke-w1 \
std01-rke-w2 \
std01-rke-w3 

### aws_list.sh

List AWS Lightsail VM , private IP and public IP

### aws_provision.sh

Provision instances into AWS Lightsail for Rancher demo

### aws_cleanup.sh

Clean up Rancher demo instances on AWS Lightsail instances

### example to start VM with namespace std01
```
./aws_provision.sh std01
```