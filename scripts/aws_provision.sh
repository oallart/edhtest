#!/bin/bash
# aws provisioning steps - some are interactive
# purpose: quickly provisions an ec2 instance based on parameters given at the top 
# and returns its instance ID and public access name.
#
# Warning, this script comes with absolutely no waranty, no even one of purpose
# Use at your own risk.
# 
MYKEY="mykey"
MYGROUP="mysg"
SGDESC="Test security group"
AMI="ami-bf86aedc" #xenial server release 20160627 ebs-ssd amd64 ap-southeast-2 paravirtual
TYPE="m3/medium"
ROOTSIZE="50"
INSTANCEFILE="/tmp/instance_info"

#Do it now
pip install awscli
aws configure
aws ec2 create-key-pair --key-name $MYKEY --query 'KeyMaterial' --output text > $MYKEY.pem
aws ec2 create-security-group --group-name $MYGROUP --description "$SGDESC"
aws ec2 authorize-security-group-ingress --group-name $MYGROUP --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name $MYGROUP --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name $MYGROUP --protocol tcp --port 8001 --cidr 0.0.0.0/0
aws ec2 run-instances --image-id $AMI --instance-type $TYPE --key-name $MYKEY --security-groups $MYSG --count 1 --block-device-mappings '[ {"DeviceName":"/dev/sda1","Ebs": { "VolumeSize": $ROOTSIZE } } ]' > $INSTANCEFILE 
INSTANCEID=`grep -e InstanceId $INSTANCEFILE | cut -d "\"" -f4 `
echo InstanceId: $INSTANCEID
PUBLICNAME=`aws ec2 describe-instances --instance-id $INSTANCEID | grep PublicDnsName | cut -d "\"" -f4 | uniq`
echo Instance Access Name: $PUBLICNAME

