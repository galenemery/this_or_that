#!/bin/bash
yum update -y
amazon-linux-extras install postgresql10 vim epel -y

#install & setup postgres 10
yum install -y postgresql-server postgresql-devel
/usr/bin/postgresql-setup --initdb
echo "listen_addresses = '*'" | tee -a /var/lib/pgsql/data/postgresql.conf
echo "host  all     all     0.0.0.0/0   trust" | tee -a /var/lib/pgsql/data/pg_hba.conf

#start postgres
echo "starting postgres"
systemctl enable postgresql
systemctl start postgresql

#config postgres for external connections


#install .net for the worker
