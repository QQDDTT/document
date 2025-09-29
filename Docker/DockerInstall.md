# 如何在 Ubuntu LTS 安装 Docker

##  卸载旧版 Docker（如果已安装）
```bash
sudo apt remove docker docker-engine docker.io containerd runc -y

##  更新系统并安装依赖
```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg
这些是 Docker 需要的基础软件包。

##  添加 Docker 官方 GPG 密钥
```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

##  添加 Docker 软件源
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
```

##  安装 Docker
```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

##  启动并设置开机自启
```bash
sudo systemctl enable --now docker
```

##  验证安装
```bash
docker --version
```

##  让当前用户运行 Docker（可选）
```bash
sudo usermod -aG docker $USER
docker ps
```

##  安装 Docker Compose（可选）
```bash
sudo apt install -y docker-compose-plugin
docker compose version
```

