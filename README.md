# Objective
this is a pre-defined AWS Lightsail script to provision instances to kick start a Rancher demo environment for workshop.

the script will provision 5 VM on Singapore ap-southeast-1 with ***medium size (2 CPU,4G RAM,80G SSD)*** and ***opensuse_15_2*** also tags namespace 

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

$ aws lightsail download-default-key-pair --output text --query privateKeyBase64 > ~/.ssh/lightsail-default-key
chmod 600 ~/.ssh/lightsail-default-key
```

### SSH into the AWS Lightsail VM

ssh -i LightsailDefaultKey-ap-southeast-1.pem ec2-user@< IP-address >




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

### Example aws_list.sh

List AWS Lightsail VM , private IP and public IP

example output
```
./aws_list.sh
+ aws lightsail get-instances --region ap-southeast-1 --query 'instances[].{publicIpAddress:publicIpAddress,privateIpAddress:privateIpAddress,VMname:name}' --output table --no-cli-pager
----------------------------------------------------------
|                      GetInstances                      |
+---------------+--------------------+-------------------+
|    VMname     | privateIpAddress   |  publicIpAddress  |
+---------------+--------------------+-------------------+
|  std01-rke-w2 |  172.26.4.87       |  18.142.43.254    |
|  std01-rke-w3 |  172.26.2.154      |  3.0.54.209       |
|  std01-rke-m1 |  172.26.9.59       |  18.140.54.214    |
|  std01-rancher|  172.26.5.3        |  54.169.12.141    |
|  std01-rke-w1 |  172.26.8.244      |  54.179.176.80    |
+---------------+--------------------+-------------------+
```
### Example aws_provision.sh

Provision instances into AWS Lightsail for Rancher demo

example output
```
$ ./aws_provision.sh std01
operations:
- createdAt: '2021-08-12T12:30:42.177000+08:00'
  id: 8869838e-fc1e-4774-a76d-0364364fa0c7
  isTerminal: false
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationType: CreateInstance
  resourceName: std01-rancher
  resourceType: Instance
  status: Started
  statusChangedAt: '2021-08-12T12:30:42.177000+08:00'
- createdAt: '2021-08-12T12:30:42.177000+08:00'
  id: 5329121d-a473-470c-9b08-ea29b1d6a375
  isTerminal: false
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationType: CreateInstance
  resourceName: std01-rke-m1
  resourceType: Instance
  status: Started
  statusChangedAt: '2021-08-12T12:30:42.177000+08:00'
- createdAt: '2021-08-12T12:30:42.177000+08:00'
  id: cbd28465-e468-4183-a2d8-aa8200fe4418
  isTerminal: false
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationType: CreateInstance
  resourceName: std01-rke-w1
  resourceType: Instance
  status: Started
  statusChangedAt: '2021-08-12T12:30:42.177000+08:00'
- createdAt: '2021-08-12T12:30:42.177000+08:00'
  id: 76d22be6-49fc-405f-afc2-27ebdea8c168
  isTerminal: false
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationType: CreateInstance
  resourceName: std01-rke-w2
  resourceType: Instance
  status: Started
  statusChangedAt: '2021-08-12T12:30:42.177000+08:00'
- createdAt: '2021-08-12T12:30:42.177000+08:00'
  id: 6aeebd56-632c-493a-8852-4355049dd58c
  isTerminal: false
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationType: CreateInstance
  resourceName: std01-rke-w3
  resourceType: Instance
  status: Started
  statusChangedAt: '2021-08-12T12:30:42.177000+08:00'
operation:
  createdAt: '2021-08-12T12:31:45.819000+08:00'
  id: 6186041a-d6ff-4d49-9a6d-7cb43ca5f1e2
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: 22/tcp,80/tcp,443/tcp,8--1/icmp
  operationType: PutInstancePublicPorts
  resourceName: std01-rancher
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:31:45.819000+08:00'
operation:
  createdAt: '2021-08-12T12:31:47.791000+08:00'
  id: 5edfdb63-222e-429f-bff8-449580f06267
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: 22/tcp,80/tcp,443/tcp,8--1/icmp
  operationType: PutInstancePublicPorts
  resourceName: std01-rke-m1
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:31:47.791000+08:00'
operation:
  createdAt: '2021-08-12T12:31:49.503000+08:00'
  id: 300ecbff-170b-448e-b784-6b694e1bbdd8
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: 22/tcp,80/tcp,443/tcp,8--1/icmp
  operationType: PutInstancePublicPorts
  resourceName: std01-rke-w1
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:31:49.503000+08:00'
operation:
  createdAt: '2021-08-12T12:31:51.251000+08:00'
  id: 323fd2c0-cc18-42a9-8655-5fc170566aed
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: 22/tcp,80/tcp,443/tcp,8--1/icmp
  operationType: PutInstancePublicPorts
  resourceName: std01-rke-w2
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:31:51.251000+08:00'
operation:
  createdAt: '2021-08-12T12:31:53.078000+08:00'
  id: a3380e9c-1d25-4ebc-88e7-55ceed61604d
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: 22/tcp,80/tcp,443/tcp,8--1/icmp
  operationType: PutInstancePublicPorts
  resourceName: std01-rke-w3
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:31:53.078000+08:00'
```
### Example aws_cleanup.sh

Clean up Rancher demo instances on AWS Lightsail instances

example output
```
$ ./aws_cleanup.sh std01
+ aws lightsail delete-instance --region ap-southeast-1 --instance-name std01-rancher --output yaml --no-cli-pager
operations:
- createdAt: '2021-08-12T12:26:29.199000+08:00'
  id: eeefc556-0ae6-4e40-ac4b-6251c71f9d0d
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: ''
  operationType: DeleteInstance
  resourceName: std01-rancher
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:26:29.199000+08:00'
+ aws lightsail delete-instance --region ap-southeast-1 --instance-name std01-rke-m1 --output yaml --no-cli-pager
operations:
- createdAt: '2021-08-12T12:26:30.912000+08:00'
  id: 38729d83-3f62-4c65-91c8-306a9b1280cd
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: ''
  operationType: DeleteInstance
  resourceName: std01-rke-m1
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:26:30.912000+08:00'
+ aws lightsail delete-instance --region ap-southeast-1 --instance-name std01-rke-w1 --output yaml --no-cli-pager
operations:
- createdAt: '2021-08-12T12:26:32.577000+08:00'
  id: defe2051-3215-4683-86bd-6512bcd2eef0
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: ''
  operationType: DeleteInstance
  resourceName: std01-rke-w1
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:26:32.577000+08:00'
+ aws lightsail delete-instance --region ap-southeast-1 --instance-name std01-rke-w2 --output yaml --no-cli-pager
operations:
- createdAt: '2021-08-12T12:26:34.583000+08:00'
  id: e2048342-0a21-444f-bd02-43bf0d3fca67
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: ''
  operationType: DeleteInstance
  resourceName: std01-rke-w2
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:26:34.583000+08:00'
+ aws lightsail delete-instance --region ap-southeast-1 --instance-name std01-rke-w3 --output yaml --no-cli-pager
operations:
- createdAt: '2021-08-12T12:26:36.541000+08:00'
  id: 19bd0276-fe24-46d9-87d1-f73278e6d1e5
  isTerminal: true
  location:
    availabilityZone: ap-southeast-1a
    regionName: ap-southeast-1
  operationDetails: ''
  operationType: DeleteInstance
  resourceName: std01-rke-w3
  resourceType: Instance
  status: Succeeded
  statusChangedAt: '2021-08-12T12:26:36.541000+08:00'
```
