#!/bin/bash -ex

### get AWS Lightsail instance
aws lightsail get-instances --region ap-southeast-1 \
--query 'instances[].{publicIpAddress:publicIpAddress,privateIpAddress:privateIpAddress,VMname:name,state:state.name}' \
--output table --no-cli-pager
