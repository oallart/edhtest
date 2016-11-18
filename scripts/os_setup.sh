#!/bin/bash
# os setup - simple and quick. can be automated and expanded at will
# purpose: installs required software on a fresh instance. 
#
# Warning, this script comes with absolutely no waranty, no even one of purpose
# Use at your own risk.
# 
apt-get install docker docker.io rsyslog-elasticsearch

# required or ES 5 won't start
#https://github.com/docker-library/elasticsearch/issues/114
sysctl -w vm.max_map_count=262144

#ENTIRELY MISSING: the rsylog config I spent 2 days on. Unngnh
# base point: https://sematext.com/blog/2013/07/01/recipe-rsyslog-elasticsearch-kibana/

systemctl start docker
systemctl enable docker
#mkdir /opt/docker-config /opt/docker-data /opt/docker-config/nginx /opt/docker-data/www

# not necessarily eth0 - can be ens3 etc
echo "Remember to update the local server IP address in nginx config to match"
DEV=`ip a | grep ^2: | cut -d: -f2` 
echo -n "$DEV: "
ip addr list $DEV | grep "inet " | cut -d' ' -f6 | cut -d/ -f1
