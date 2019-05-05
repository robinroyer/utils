LOCAL_PORT=XXXX
REMOTE_USER=user
REMOTE_HOST=xxx.xxx.xxx.Xxx
REMOTE_PORT=22


ssh -D ${LOCAL_PORT} -f -C -q -N ${REMOTE_USER}@${REMOTE_HOST} -p ${REMOTE_PORT}

#set socks setting in System settings > Network > network proxy 
gsettings set org.gnome.system.proxy mode 'manual'
gsettings set org.gnome.system.proxy.socks port ${LOCAL_PORT}
gsettings set org.gnome.system.proxy.socks host 'localhost'
gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '${LOCAL_RANGE}', '::1']"

sudo su <<-EOF  
#environment settings
echo "socks_proxy='socks://localhost:${LOCAL_PORT}/'" >> /etc/environment 
#apt settings
echo "Acquire::socks::proxy 'socks://localhost:$LOCAL_PORT/';" >> /etc/apt/apt.conf
EOF
