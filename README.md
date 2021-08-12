# AWS_lightsail

this is pre-defined aws lightsail bash script for fast deploymet.

to will take 1 parameters (student) as namespace
to provision AWS Lightsail environment for kick start Rancher Srv + RKE downstream Cluster (1 master with 3 worker node)


create-instances
```
aws lightsail create-instances --region ap-southeast-1 --instance-names  { *** $STD-rancher,$STD-rke-m1,$STD-rke-w1,$STD-rke-w2,$STD-rke-w3 *** } --availability-zone ap-southeast-1a --blueprint-id opensuse_15_2 --bundle-id medium_2_0 --ip-address-type ipv4 --user-data "systemctl enable docker;systemctl start docker;" --tags key=$STD --no-cli-pager

```

### get AWS Lightsail instance
aws lightsail get-instances --region ap-southeast-1 --query 'instances[].{publicIpAddress:publicIpAddress,privateIpAddress:privateIpAddress,VMname:name}' --output table --no-cli-pager
