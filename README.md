> English | [中文](README.zh.md)

# Obsidian Pure Launcher

A small tool to optimize the Obsidian launch experience by automatically fixing configuration and launching Obsidian.

> **Note: This project and the generated EXE are for Windows only.**

## Features

- Automatically cleans redundant strings (removes `,"open":true`) from `%APPDATA%\obsidian\obsidian.json`.
- Automatically detects and launches the locally installed Obsidian client.
- Supports one-click packaging into a single EXE file on Windows.

## Project Structure

```plaintext
obsidian-pure-launcher-win/
├── assets/
│   └── app-icon.ico
├── dist/
│   └── ... (packaged executables)
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

- `assets/`: Resource files (icons, etc.)
- `dist/`: Output directory for packaged executables
- `scripts/`: All batch and VBS scripts for launching and processing
- `src/`: Python source code and build scripts
- `README.md`, `README.zh.md`: Project documentation (English/Chinese)

## Launch Methods

This project supports three ways to launch Obsidian:

### Method 1: Launch via EXE

This method requires a pre-installed Python environment and is suitable for developers or users who want a single executable.

#### Build Requirements

- Windows OS
- Python 3.7 or higher
- pip
- pyinstaller (auto-installed on first build)

#### Build Steps

1. Ensure Python 3 and pip are installed (`python --version` and `pip --version`).
2. Go to the `src` directory and run `build.bat` (double-click or via command line).
3. The script will auto-install pyinstaller if needed, and continue building after installation.
4. The packaged EXE will be output to the `dist` directory.

#### Using the Packaged EXE

1. Run the generated `obsidian-pure-launcher.exe` (Windows only).
2. The program will automatically clean the Obsidian config and attempt to launch the Obsidian client.
3. If Obsidian does not launch, check if it is installed in one of the following supported paths:
   - `%LOCALAPPDATA%\Obsidian\Obsidian.exe` (user install)
   - `%PROGRAMFILES%\Obsidian\Obsidian.exe` (system install)
   - `%PROGRAMFILES(X86)%\Obsidian\Obsidian.exe` (32-bit install)
   - `%PROGRAMW6432%\Obsidian\Obsidian.exe` (64-bit install)
   - Any path in the system PATH containing `obsidian.exe`

### Method 2: Launch via BAT File

- **Silent mode**: Double-click `start_obsidian.bat` to launch Obsidian without console output.
- **Console mode**: Double-click `start_obsidian_console.bat` to launch with detailed console output for debugging.

**Supported install paths:**

- `%LOCALAPPDATA%\Obsidian\Obsidian.exe` (user install)
- `%PROGRAMFILES%\Obsidian\Obsidian.exe` (system install)
- `%PROGRAMFILES(X86)%\Obsidian\Obsidian.exe` (32-bit install)
- `%PROGRAMW6432%\Obsidian\Obsidian.exe` (64-bit install)
- Any path in the system PATH containing `obsidian.exe`

### Method 3: Launch via VBS File (Recommended/Best Practice)

Place `Obsidian.vbs` in the same directory as `Obsidian.exe`, then point the `Obsidian.lnk` (shortcut) target to this VBS file.

Alternatively, you can create a separate shortcut for the VBS file and set its icon to `Obsidian.exe` for a seamless experience.

This approach allows for silent config processing and automatic launch of Obsidian, with maximum compatibility and no need to search for the executable path.

## Contributing

Contributions are welcome! Please submit issues and pull requests to help improve this project.
