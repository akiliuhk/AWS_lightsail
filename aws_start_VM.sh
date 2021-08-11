#!/bin/bash -ex

export STD=std01

aws lightsail start-instance --instance-name $STD-rancher --output yaml --no-cli-pager

aws lightsail start-instance --instance-name $STD-rke-m1 --output yaml --no-cli-pager

aws lightsail start-instance --instance-name $STD-rke-w1 --output yaml --no-cli-pager

aws lightsail start-instance --instance-name $STD-rke-w2 --output yaml --no-cli-pager

aws lightsail start-instance --instance-name $STD-rke-w3 --output yaml --no-cli-pager

