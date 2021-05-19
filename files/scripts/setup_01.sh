#!/bin/bash
#before running, replace redis_host here with the correct IP address for server_03
echo REDIS="10.0.0.50" | sudo tee -a /etc/environment

#Initialization and installs
yum update -y
yum install git -y

#bring down the python app
mkdir /app
chmod 777 /app
git clone https://github.com/galenemery/this_or_that.git
mv this_or_that/vote/vote /app/vote
mv this_or_that/result /app/result

#run the vote app
cd /app/vote
pip3 install -r /app/vote/requirements.txt
/usr/local/bin/gunicorn app:app -D -b 0.0.0.0:8080 --log-file - --access-logfile - --workers 4 --keep-alive 0
echo "gunicorn running"
ps aux | grep python

#install and configure results app
cd /app/result
# Download/configure NVM (could direct install node but did this for version compatibility if necessary)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
# Set nvm vars so you don't have to restart terminal
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# Install node (change to a specific version if library issues arise with postgres)
nvm install 10
# Install tini 
npm install forever
# Install dependencies
npm install
# Start server (port 8082)
forever start server.js 8082