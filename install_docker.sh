yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
yum install -y yum-utils \
                      device-mapper-persistent-data \
                      lvm2
yum-config-manager \
       --add-repo \
       https://download.docker.com/linux/centos/docker-ce.repo
yum update
yum install docker-ce docker-ce-cli containerd.io
# 该配置文件及目录，在Docker安装后并不会自动创建
mkdir -p /etc/docker
# 配置加速地址
tee /etc/docker/daemon.json <<-'EOF'
{
   "registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF
# 重启服务
systemctl daemon-reload
systemctl restart docker
systemctl enable docker
systemctl start docker
# 从GitHub下载
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
