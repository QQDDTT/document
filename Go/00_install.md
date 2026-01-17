# Go 语言安装

- 安装包下载地址

https://go.dev/dl/

https://golang.google.cn/dl/


# Linux

1. 下载二进制包：go1.4.linux-amd64.tar.gz。

2. 将下载的二进制包解压至 /usr/local目录。

```bash
tar -C /usr/local -xzf go1.4.linux-amd64.tar.gz
```

3. 将 /usr/local/go/bin 目录添加至 PATH 环境变量

- 编辑 ~/.bash_profile 或者 /etc/profile

```bash
nano ~/.bash_profile
```

```bash
export PATH=$PATH:/usr/local/go/bin
```

- 添加后需要执行

```bash
source ~/.bash_profile

source /etc/profile
```

# Windows

- 默认情况下 .msi 文件会安装在 c:\Go 目录下。你可以将 c:\Go\bin 目录添加到 Path 环境变量中。