#!/bin/bash
cd /app/vote
sudo pip3 install -r /app/vote/requirements.txt
gunicorn app:app -D -b 0.0.0.0:8080 --log-file - --access-logfile - --workers 4 --keep-alive 0
echo "gunicorn running"
ps aux | grep python