#!/bin/bash
# docker run - A list of images to run in that order.
# purpose: starts all the right docker images with the proper configuration
# this is the last step, and requires all the configuration and pre-requisites to be in place.
#
# This can be done better with docker-compose, yes.
#
# Warning, this script comes with absolutely no waranty, no even one of purpose
# Use at your own risk.
# 
docker run -d -p 80:80 -p 8001:8001 -v /opt/docker-data/www/:/usr/share/nginx/html/ -v /opt/docker-config/nginx/default.conf:/etc/nginx/conf.d/default.conf:ro -v /opt/docker-config/nginx/kibana.htpasswd:/etc/nginx/conf.d/kibana.htpasswd:ro --log-driver=syslog --log-opt tag="nginx" nginx
docker run --name elasticsearch-int -d -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 elasticsearch
docker run --name kibana-int -d -p 5601:5601 --link elasticsearch-int:elasticsearch kibana 

# es version 2.4.1
docker run --name elasticsearch-int2.4.1 -d -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 elasticsearch:2.4.1
