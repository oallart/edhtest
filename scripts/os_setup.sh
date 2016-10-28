#!/bin/bash
# os setup - simple and quick. can be automated and expanded at will
# purpose: installs required software on a fresh instance. 
#
# Warning, this script comes with absolutely no waranty, no even one of purpose
# Use at your own risk.
# 
apt-get install docker docker.io rsyslog-elasticsearch
#https://github.com/docker-library/elasticsearch/issues/114
sysctl -w vm.max_map_count=262144

systemctl start docker
systemctl enable docker
mkdir /opt/docker-config /opt/docker-data /opt/docker-config/nginx /opt/docker-data/www
LOCALIP=`ip addr show dev eth0 | grep "inet " | cut -d "/" -f 1`
echo "Remember to update the local server IP address in nginx config to match" $LOCALIP
