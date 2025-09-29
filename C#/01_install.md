# 使用 VS Code 开发 C# 项目

# 安装：
- .NET SDK（编译和运行 C#）
- VS Code（编辑器）
- C# 扩展插件（智能提示和调试）

## 🪟 Windows 安装流程

### 1. 安装 .NET SDK

- 下载地址：https://dotnet.microsoft.com/download
- 选择最新的 .NET SDK（包含运行时），点击 x64 Installer。
- 安装完成后验证：
  
```powershell
dotnet --version
```

### 2. 安装 VS Code

- 下载地址：https://code.visualstudio.com/
- 下载并安装 Windows Installer

### 3. 安装 C# 扩展插件

- 打开 VS Code → 左侧扩展图标 → 搜索 C# → 安装官方插件（由 Microsoft 提供）


## 4. 配置环境变量

- .NET SDK 安装程序通常自动配置环境变量。可以通过：
```powershell
$env:PATH
```
- 确认 dotnet 是否在路径中。


## 🍎 macOS 安装流程

### 1. 安装 Homebrew（如果未安装）

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. 安装 .NET SDK

```bash
brew install --cask dotnet-sdk
```
- 或者前往官网下载 .pkg 安装包：https://dotnet.microsoft.com/download
- 安装后验证：

```bash
dotnet --version
```

### 3. 安装 VS Code

```bash
brew install --cask visual-studio-code
```
- 或者手动下载安装：https://code.visualstudio.com/

### 4. 安装 C# 扩展插件

- 打开 VS Code → Extensions → 搜索 C# → 安装 Microsoft 插件

### 5. 配置环境变量

```bash
export PATH=/usr/local/share/dotnet:$PATH
```

## Linux 安装流程

### 1. 安装 .NET SDK

- 添加 Microsoft 包源：

```bash
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
```

- 安装依赖：

```bash
sudo apt-get update
sudo apt-get install -y dotnet-sdk-8.0
```

- 验证：

```bash
dotnet --version
```

- 你可以根据需要安装不同版本，如 dotnet-sdk-6.0, 7.0 等。

### 2. 安装 VS Code

```bash
sudo apt update
sudo apt install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code
```

### 3. 安装 C# 插件

- 打开 VS Code → 插件商店 → 安装 C# 插件


## 📦 可选工具推荐

| 工具             | 功能              | 安装方法                                        |
| -------------- | --------------- | ------------------------------------------- |
| `OmniSharp`    | C# 支持核心（插件自动安装） | 随 C# 插件自动下载                                 |
| `dotnet watch` | 实时编译与运行         | `dotnet tool install --global dotnet-watch` |
| `nuget`        | 管理依赖包           | 默认集成在 dotnet CLI 中                          |
