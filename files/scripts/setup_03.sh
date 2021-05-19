#!/bin/bash

#initialization
yum update -y
amazon-linux-extras install redis4.0 -y

# run redis as a daemon without protected-mode.  Do not expose this redis server to the internets.
redis-server --daemonize yes --protected-mode no
ps aux | grep redis