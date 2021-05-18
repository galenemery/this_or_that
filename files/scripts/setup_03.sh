yum update -y
sudo amazon-linux-extras install redis4.0 -y
# somehow set protected-mode no
redis-server --daemonize yes --protected-mode no
ps aux | grep redis