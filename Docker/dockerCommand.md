# 容器管理 

| 命令 | 描述 |
| --- | --- |
| docker ps | 查看正在运行的容器 |
| docker ps -a | 查看所有容器（包括已停止的容器） |
| docker start <container_name_or_id> | 启动一个容器 |
| docker stop <container_name_or_id> | 停止一个容器 |
| docker restart <container_name_or_id> | 重启一个容器 |
| docker exec -it <container_name_or_id> /bin/bash | 进入一个正在运行的容器 |
| docker rm -f <container_name_or_id> | 停止并删除容器 |
| docker logs <container_name_or_id> | 查看容器的日志 |
| docker stats <container_name_or_id> | 查看容器的资源使用情况 |

# 镜像管理

| 命令 | 描述 |
| --- | --- |
| docker images | 列出本地所有镜像 |
| docker pull <image_name> | 拉取镜像 |
| docker build -t <image_name> <path_to_dockerfile> | 构建镜像 |
| docker rmi <image_name_or_id> | 删除本地镜像 |
| docker inspect <image_name_or_id> | 查看镜像详细信息 |
| docker history <image_name_or_id> | 查看镜像历史 |

# 容器网络管理

| 命令 | 描述 |
| --- | --- |
| docker network ls | 查看容器网络 |
| docker network create <network_name> | 创建一个新的网络 |
| docker network connect <network_name> <container_name_or_id> | 连接容器到网络 |
| docker network disconnect <network_name> <container_name_or_id> | 从网络中断开容器 |

# 数据卷管理

| 命令 | 描述 |
| --- | --- |
| docker volume ls | 查看卷 |
| docker volume create <volume_name> | 创建卷 |
| docker volume inspect <volume_name> | 查看卷详细信息 |
| docker volume rm <volume_name> | 删除卷 |

# 容器日志与监控

| 命令 | 描述 |
| --- | --- |
| docker logs <container_name_or_id> | 查看容器的日志输出 |
| docker logs -f <container_name_or_id> | 实时查看容器日志 |
| docker stats <container_name_or_id> | 查看容器资源使用情况 |
 
# Docker Compose 管理

| 命令 | 描述 |
| --- | --- |
| docker-compose up | 启动 Compose 服务 |
| docker-compose up -d | 在后台启动 Compose 服务 |
| docker-compose down | 停止 Compose 服务 |
| docker-compose logs | 查看 Compose 服务的日志 |

# 系统管理

| 命令 | 描述 |
| --- | --- |
| docker info | 查看 Docker 系统信息 |
| docker --version | 查看 Docker 版本 |
| docker system prune | 清理未使用的镜像、容器、网络和卷 |
| docker image prune | 清理未使用的镜像 |
| docker container prune | 清理未使用的容器 |
| docker volume prune | 清理未使用的卷 |

# 调试与其他工具

| 命令 | 描述 |
| --- | --- |
| docker stats <container_name_or_id> | 查看容器的资源限制 |
| docker inspect <container_name_or_id> | 获取容器的详细信息 |
| docker export <container_name_or_id> > container.tar | 导出容器文件系统为 tar 文件 |
| docker import container.tar | 导入 tar 文件到 Docker 镜像 |
