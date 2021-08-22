# Objective
this is a pre-defined AWS Lightsail script to provision instances to kick start a Rancher demo environment for workshop.

the script will provision 5 VM and S3 bucket on Singapore ap-southeast-1 with ***medium size (2 CPU,4G RAM,80G SSD)*** and ***opensuse_15_2*** also tags namespace 

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
Default output format [None]: yaml
```

## AWS Lightsail CLI Reference
https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lightsail/index.html#


### Download AWS Lightsail default-key-pair
```
$ aws lightsail download-default-key-pair --output text --query publicKeyBase64 > ~/.ssh/lightsail-default-key.pub
chmod 644 ~/.ssh/lightsail-default-key.pub

$ aws lightsail download-default-key-pair --output text --query privateKeyBase64 > ~/.ssh/lightsail-default-key.pem
chmod 600 ~/.ssh/lightsail-default-key.pem
```

### SSH into the AWS Lightsail VM

ssh -i ~/.ssh/lightsail-default-key.pem -o StrictHostKeyChecking=no ec2-user@< IP-address >


## Example to provision VM with namespace std01

for example , I want to provision with namespace std01 
```
./aws_provision.sh std01
```
you will see AWS Lightsail started 5 VM with the input namespace std01

std01-rancher \
std01-rke-m1 \
std01-rke-w1 \
std01-rke-w2 \
std01-rke-w3 

### example output of the Lab folder
```
Lab folder structure
std01-lab-info                       # std01 lab folder
├── ssh-std01-rancher.sh             # rancher server node ssh file
├── ssh-std01-rke-m1.sh              # rke-cluster-1 master1 node ssh file
├── ssh-std01-rke-w1.sh              # rke-cluster-1 worker1 node ssh file
├── ssh-std01-rke-w2.sh              # rke-cluster-1 worker2 node ssh file
├── ssh-std01-rke-w3.sh              # rke-cluster-1 worker3 node ssh file
├── std01-default-key.pem            # Lab environment default ssh key
├── std01-get-instances.txt          # Lab environment IP list
├── std01-rancher.html               # rancher server html page
├── std01-s3-bucket-accessKeys.txt.  # s3-bucket access key
└── std01-s3-bucket.txt              # s3-bucket name and url

```


### Example aws_provision.sh

Provision instances into AWS Lightsail for Rancher demo

example output
```
$ ./aws_provision.sh std01

```
### Example aws_cleanup.sh

Clean up Rancher demo instances on AWS Lightsail instances

example output
```
$ ./aws_cleanup.sh std01

```
