@echo off
chcp 65001
setlocal enabledelayedexpansion

REM 修改Obsidian配置文件
set "json_file=%APPDATA%\obsidian\obsidian.json"
if  exist "%json_file%" (
    echo [FOUND] obsidian.json: %json_file%
    echo [LOG] Modifying obsidian.json...
    powershell -Command "$c = [System.IO.File]::ReadAllText('%json_file%'); $c = $c -replace ',\"open\":true', ''; [System.IO.File]::WriteAllText('%json_file%', $c, (New-Object System.Text.UTF8Encoding($false)))" >nul
    echo [SUCCESS] Modified successfully
) else (
    echo [WARNING] obsidian.json: %json_file%
)

REM 查找常用软件安装目录，拼接Obsidian.exe路径
set "dirs="%LOCALAPPDATA%" "%ProgramFiles%" "%ProgramFiles(x86)%" "%ProgramW6432%""

set "found=0"
for %%D in (%dirs%) do (
    set "obsidianexe=%%~D\Obsidian\Obsidian.exe"
    if exist "!obsidianexe!" (
        echo [FOUND] Obsidian.exe: !obsidianexe!
        if !found! equ 0 (
            start "" "!obsidianexe!"
            echo [SUCCESS] Opened: !obsidianexe!
            set "found=1"
        )
    ) else (
        echo [NOT FOUND] Obsidian.exe: !obsidianexe!
    )
)

@REM REM 遍历 Desktop、Start Menu、Common Start Menu...
@REM set "desktop=%USERPROFILE%\Desktop"
@REM set "startmenu=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
@REM set "commonstartmenu=%ProgramData%\Microsoft\Windows\Start Menu\Programs"

@REM echo [LOG] desktop: %desktop%
@REM echo [LOG] startmenu: %startmenu%
@REM echo [LOG] commonstartmenu: %commonstartmenu%

@REM for %%D in ("%desktop%" "%startmenu%" "%commonstartmenu%") do (
@REM     for /f "delims=" %%R in ("%%~D") do (
@REM         pushd "%%R" >nul 2>&1
@REM         if not errorlevel 1 (
@REM             for /r %%H in (*.lnk) do (
@REM                 @REM echo [LOG] 快捷方式路径: %%H
@REM                 @REM echo [LOG] 快捷方式名称: %%~nH
@REM                 echo %%~nH | findstr /I "Obsidian" >nul
@REM                 if not errorlevel 1 (
@REM                     for /f "usebackq delims=" %%T in (`powershell -NoProfile -Command "(New-Object -ComObject WScript.Shell).CreateShortcut('%%H').TargetPath"`) do set "target=%%T"
@REM                     echo [FOUND] Obsidian 快捷方式目标: !target!
@REM                 )
@REM             )
@REM             popd
@REM         )
@REM     )
@REM )