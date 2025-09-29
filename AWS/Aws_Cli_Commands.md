# AWS CLI 常用命令总结

---
## 基础配置

```bash
aws configure
> 配置 Access Key ID，Secret Access Key，Region（默认地区），输出格式 (json、table或 text)。
```
---
## 查看当前账号和地区信息

```bash
aws sts get-caller-identity
> 显示当前使用的 AWS 账号、认证信息和账号ID。

aws configure get region
> 显示当前 CLI 配置的地区信息。
```
---
## S3 (对象存储)

```bash
aws s3 ls
> 列出当前账号所有的 S3 bucket。

aws s3 ls s3://your-bucket-name/
> 查看指定 bucket 中的文件和文件夹。

aws s3 cp localfile.txt s3://your-bucket-name/
> 上传本地文件到 bucket。

aws s3 cp s3://your-bucket-name/file.txt .
> 从 bucket 下载指定文件到当前目录。

aws s3 sync ./local-folder/ s3://your-bucket-name/remote-folder/
> 将本地目录整合到 bucket 中（会自动处理新增和更改的文件）。
```
---
## EC2 (云服务器)

```bash
aws ec2 describe-instances
> 查看已创建的所有虚拟机信息，包括状态 IP 地址等。

aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx
> 启动指定ID的 EC2 实例（虚拟机）。

aws ec2 stop-instances --instance-ids i-xxxxxxxxxxxxxxxxx
> 停止指定ID的 EC2 实例。

aws ec2 reboot-instances --instance-ids i-xxxxxxxxxxxxxxxxx
> 重启指定ID的 EC2 实例。
```
---
## ECR (容器镜像仓库)

```bash
aws ecr get-login-password | docker login --username AWS --password-stdin xxxxxxxx.dkr.ecr.region.amazonaws.com
> 获取 ECR 登录密码，并用 Docker 登录到指定 ECR 地址。

aws ecr describe-repositories
> 查看已创建的所有镜像仓库列表。

aws ecr create-repository --repository-name my-repo
> 创建新的镜像仓库。

aws ecr list-images --repository-name my-repo
> 查看指定仓库中的所有镜像。

aws ecr batch-delete-image --repository-name my-repo --image-ids imageDigest=sha256:xxxxxx
> 批量删除指定镜像。
```
---
## IAM (用户和权限)

```bash
aws iam list-users
> 列出已创建的所有 IAM 用户。

aws iam create-user --user-name new-user
> 创建一个新的 IAM 用户。

aws iam delete-user --user-name new-user
> 删除指定的 IAM 用户。

aws iam list-roles
> 列出已创建的所有 IAM 角色。
```
---
## CloudFormation (基础设施即代码)
```bash
aws cloudformation describe-stacks
> 查看所有已立体化的堆栈信息。

aws cloudformation create-stack --stack-name mystack --template-body file://template.yaml
> 使用本地 YAML 文件创建一个新的 CloudFormation 堆栈。

aws cloudformation delete-stack --stack-name mystack
> 删除指定的 CloudFormation 堆栈。
```

