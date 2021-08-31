# Objective
this is a pre-defined script to provision AWS Lightsail instances for Rancher workshop.

to start using this script, you have to install AWS CLI v2.

the script will provision 5 VM and S3 bucket on Singapore ap-southeast-1 with ***medium size (2 CPU,4G RAM,80G SSD)*** and ***opensuse_15_2*** with tags < std01 > 


## Rancher workshop sizing and budget

Each student will have 5 VM ( 1 rancher server on K3s + 1 master node and 3 worker node for downstream RKE cluster ) 

AWS Lightsail Medium size VM - 2 vCPU and 4G Ram 80G SSD = 20 USD per month.

### Daily pricing = (20 usd * 5 VM / 720h ) * 24h = 3.4 usd each student

Assuming 20 student will be joining this workshop = 3.4 * 20 = 68 usd 

## AWS CLI installation 

AWS CLI version 2 installation instructions:

https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html


## AWS CLI configure credentials
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html 

```
$ aws configure
AWS Access Key ID [None]: AKIAIOSF-----EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/----------------EXAMPLEKEY
Default region name [None]: ap-southeast-1
Default output format [None]: table
```

## AWS Lightsail CLI Reference
https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lightsail/index.html#


## Example - provision AWS lightsail env for std01

To provision instances into AWS Lightsail for Rancher workshop environemnt for <std01>

```
$ ./aws_provision.sh std01
```

## Example - cleanup AWS lightsail env for std01

To clean up Rancher workshop environemnt on AWS Lightsail instances for <std01>

```
$ ./aws_cleanup.sh std01

```


## Example <std01> - Lab folder structure
```
$ std01-lab-info # std01 lab folder
├── ssh-std01-rancher.sh # rancher server node ssh file
├── ssh-std01-rke-m1.sh # rke-cluster-1 master1 node ssh file
├── ssh-std01-rke-w1.sh # rke-cluster-1 worker1 node ssh file
├── ssh-std01-rke-w2.sh # rke-cluster-1 worker2 node ssh file
├── ssh-std01-rke-w3.sh # rke-cluster-1 worker3 node ssh file
├── std01-default-key.pem # Lab environment default ssh key
├── std01-get-instances.txt # Lab environment IP list
├── std01-rancher-port-80.html # rancher server html page
├── std01-rke-w1-port-30080.html # rke-w1 NodePort html page
├── std01-rke-w1-port-31080.html # rke-w1 NodePort html page
├── std01-s3-bucket-accessKeys.txt. # s3-bucket access key
└── std01-s3-bucket.txt # s3-bucket name and url
```