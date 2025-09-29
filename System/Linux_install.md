## 1. 制作 Linux 启动 U 盘

### 1.1 下载 Linux ISO
- 推荐发行版（支持 Surface 触摸屏较好）：

- Ubuntu 22.04 LTS（官方支持触摸屏）
- Fedora 39（Wayland 适配较好）
- Arch Linux（需要手动配置，适合高级用户）
-  从官方网站下载 ISO 镜像：

- Ubuntu 官方网站 https://ubuntu.com/download/desktop
- Fedora 官方网站 https://ubuntu.com/download/desktop
- Arch Linux 官方网站 

### 1.2 制作 U 盘启动盘
- 在 Windows 下，可以使用 Rufus 制作启动 U 盘：

- 下载 Rufus → 官网 https://rufus.ie/ja/
- 插入 至少 8GB U 盘（⚠️ U 盘数据会被清空）
- 选择：
  - ISO 镜像（下载的 Linux ISO）
  - 分区方案：GPT
  - 文件系统：FAT32（兼容性较好）
  - 点击开始 → 制作完成后 安全弹出 U 盘
```bash
sudo dd if=/path/to/linux.iso of=/dev/sdX bs=4M status=progress && sync
```
- （⚠️ /dev/sdX 请替换成实际的 U 盘设备）



## 2. 备份 Surface 电脑数据（重点：WSL）

### 2.1 备份 WSL 数据

- 列出 WSL 发行版
- wsl --list --verbose

- 导出 WSL 发行版
```bash
wsl --export Ubuntu D:\backup\ubuntu.tar
```
- 备份 WSL 的根目录
```bash
tar -cvf D:\backup\wsl-home.tar C:\Users\<你的用户名>\AppData\Local\Packages\CanonicalGroupLimited*
```
- 复制备份文件到 外部硬盘 / U 盘
```bash
copy D:\backup\*.tar E:\backup\
```

### 2.2 备份 Windows 个人文件
- 手动备份：

  - 文档（C:\Users\你的用户名\Documents）
  - 桌面（C:\Users\你的用户名\Desktop）
  - 下载（C:\Users\你的用户名\Downloads）
  - SSH 密钥（C:\Users\你的用户名\.ssh\）
  - 一键打包：
```bash
tar -cvf D:\backup\windows-home.tar C:\Users\你的用户名
```

## 3. 删除 Windows，安装 Linux

### 3.1 进入 BIOS

- 关机 → 按 音量上键 + 电源键 进入 BIOS
- 在 Boot 菜单 中启用：
- USB Boot（允许从 U 盘启动）
- Secure Boot（推荐关闭）
- TPM（保持开启）
- Fast Boot（建议关闭）
- 保存 & 退出

### 3.2 启动 Linux 安装
- 插入 U 盘
- 启动 Surface → 进入 Boot Menu
- 按 音量减键 + 电源键
- 选择 U 盘启动
- 进入 Linux 安装界面

### 3.3 分区（删除 Windows）
- 选择 手动分区
- 删除 Windows 分区
- 一般是 /dev/nvme0n1pX（NTFS 格式）

- 创建 Linux 分区：

| 挂载点 | 大小 | 格式 |
| - | - | - |
| /（根目录） | 50GB 以上 | ext4 |
| /home（可选） | 剩余空间 | ext4 |
| /swap（交换分区） | 8GB | swap |


## 4. 安装触摸屏驱动
 
### 4.1 安装 linux-surface 内核
 
- Ubuntu/Debian 系列：
```bash
 curl -fsSL https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | sudo tee /usr/share/keyrings/surface.asc
echo "deb [signed-by=/usr/share/keyrings/surface.asc] https://pkg.surfacelinux.com/debian release main" | sudo tee /etc/apt/sources.list.d/linux-surface.list
sudo apt update
sudo apt install linux-image-surface linux-headers-surface iptsd
sudo reboot
```
- Fedora 系列：
```bash
sudo dnf copr enable samtod/linux-surface
sudo dnf install kernel-surface iptsd
sudo reboot
```

### 4.2 启用触摸屏支持
```bash
sudo systemctl enable --now iptsd
```

## 5. 恢复 WSL 数据

### 5.1 安装 WSL 兼容环境
- 如果你想继续使用 WSL 的数据，需要 systemd-nspawn 或者 LXD/LXC 来创建一个兼容环境。

### 5.2 恢复 WSL
- 创建 LXD 容器
```bash
lxd init
lxc launch images:ubuntu/22.04 wsl-container
```
- 导入 WSL 备份
```bash
lxc file push ubuntu.tar wsl-container/root/
lxc exec wsl-container -- bash
```
- 恢复文件
```bash
tar -xvf /root/ubuntu.tar -C /
```

## 6. 设置 Linux，优化 Surface 体验
### 6.1 触摸屏优化
```bash
gsettings set org.gnome.desktop.interface enable-animations true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
```
## 6.2 触控键盘
```bash
sudo apt install onboard
```
- 启动触控键盘：
```bash
onboard
```
### 6.3 Surface 专用电池优化
```bash
sudo apt install tlp tlp-rdw
sudo systemctl enable --now tlp
```

