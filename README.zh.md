> 中文 | [English](README.md)

# Obsidian Pure Launcher

一个用于优化 Obsidian 启动体验的小工具，自动修正配置并启动 Obsidian。

> **注意：本项目及生成的 EXE 仅适用于 Windows 系统。**

## 功能简介

- 自动修正 `%APPDATA%\obsidian\obsidian.json` 文件中的冗余字符串（去除 `,"open":true`）。
- 自动检测并启动本地已安装的 Obsidian 客户端。
- 支持 Windows 下一键打包为单文件 EXE。

## 项目目录结构

```plaintext
obsidian-pure-launcher-win/
├── assets/
│   └── app-icon.ico
├── dist/
│   └── ...（打包生成的可执行文件）
├── scripts/
│   ├── obsidian.bat
│   ├── obsidian.log.vbs
│   ├── obsidian.vbs
│   ├── start_obsidian.bat
│   ├── start_obsidian_console.bat
│   ├── start_obsidian.vbs
│   └── start_obsidian_console.vbs
├── src/
│   ├── build.bat
│   ├── main.py
│   └── registry_utils.py
├── README.md
├── README.zh.md
```

- `assets/`：图标等资源文件
- `dist/`：打包生成的可执行文件
- `scripts/`：所有启动、处理相关的批处理和 VBS 脚本
- `src/`：Python 源码及打包脚本
- `README.md`、`README.zh.md`：项目说明文档

## 启动方式说明

本项目支持三种启动 Obsidian 的方式：

### 方式 1. 通过 exe 文件启动

此方法需要提前准备 Python 环境，适合开发者或希望使用单一可执行文件的用户。

#### 构建环境要求

- Windows 操作系统
- Python 3.7 及以上
- pip
- pyinstaller（首次打包时自动安装）

#### 打包方法

1. 确保已安装 Python 3 和 pip（可在命令行输入 `python --version` 和 `pip --version` 检查）。
2. 进入 `src` 目录，双击或在命令行运行 `.\build.bat`。
3. 首次打包会自动安装 pyinstaller，安装完成后脚本会自动重启并继续打包，无需手动分步操作。
4. 打包完成后，EXE 文件会输出到 `dist` 目录。

#### 使用打包后的 EXE

1. 运行打包生成的 `obsidian-pure-launcher.exe`（仅限 Windows）。
2. 程序会自动修正 Obsidian 配置文件并尝试启动 Obsidian 客户端。
3. 若 Obsidian 未成功启动，请检查其是否安装在如下支持的路径中。
   - `%LOCALAPPDATA%\Obsidian\Obsidian.exe`（用户安装）
   - `%PROGRAMFILES%\Obsidian\Obsidian.exe`（系统安装）
   - `%PROGRAMFILES(X86)%\Obsidian\Obsidian.exe`（32 位安装）
   - `%PROGRAMW6432%\Obsidian\Obsidian.exe`（64 位安装）
   - 系统 PATH 中任何包含 `obsidian.exe` 的路径

### 方式 2. 通过 bat 文件启动

- **静默模式**：双击 `start_obsidian.bat` 直接启动 Obsidian，无控制台输出。
- **控制台模式**：双击 `start_obsidian_console.bat` 启动并显示详细的控制台输出，便于调试。

**此方法支持的安装路径**：

- `%LOCALAPPDATA%\Obsidian\Obsidian.exe`（用户安装）
- `%PROGRAMFILES%\Obsidian\Obsidian.exe`（系统安装）
- `%PROGRAMFILES(X86)%\Obsidian\Obsidian.exe`（32 位安装）
- `%PROGRAMW6432%\Obsidian\Obsidian.exe`（64 位安装）
- 系统 PATH 中任何包含 `obsidian.exe` 的路径

### 方式 3. 通过 vbs 文件启动（推荐/最优解）

将 `Obsidian.vbs` 放到 `Obsidian.exe` 的同一目录下，然后将 `Obsidian.lnk`（快捷方式）的目标指向该 vbs 文件即可。

或者，也可以为该 vbs 文件单独创建一个快捷方式，并将该快捷方式的图标指向 `Obsidian.exe`，可达到同样的效果。

这样可以实现静默处理配置并自动启动 Obsidian，无需额外查找路径，兼容性最佳。

## 贡献

欢迎提交 issue 和 PR 改进本项目。
