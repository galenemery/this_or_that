#!/bin/bash
#Env variables
echo REDIS="10.0.0.50" | sudo tee -a /etc/environment

#Initial config
yum update -y
amazon-linux-extras install postgresql10 vim epel -y
yum install git -y
git clone https://github.com/galenemery/this_or_that.git

#install & setup postgres 10
yum install -y postgresql-server postgresql-devel
/usr/bin/postgresql-setup --initdb
echo "listen_addresses = '*'" | tee -a /var/lib/pgsql/data/postgresql.conf
echo "host  all     all     0.0.0.0/0   trust" | tee -a /var/lib/pgsql/data/pg_hba.conf

#start postgres
echo "starting postgres"
systemctl enable postgresql
systemctl start postgresql
