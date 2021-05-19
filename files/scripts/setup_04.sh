#!/bin/bash
yum update -y
amazon-linux-extras install postgresql10 vim epel

#install postgres 10
yum install -y postgresql-server postgresql-devel
/usr/bin/postgresql-setup –-initdb

#start postgres
systemctl enable postgresql
systemctl start postgresql

