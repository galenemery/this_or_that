#!/bin/bash

#initialization
yum update -y
amazon-linux-extras install redis4.0 docker -y
yum install git -y
git clone https://github.com/galenemery/this_or_that.git

# run redis as a daemon without protected-mode.  Do not expose this redis server to the internets.
redis-server --daemonize yes --protected-mode no
ps aux | grep redis


#install docker to run the .net worker
systemctl enable docker
systemctl start docker

#.net worker config
cd /home/ec2-user/this_or_that/worker
docker build -t worker .
docker run worker -d