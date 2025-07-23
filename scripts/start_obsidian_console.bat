@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

echo ==========================================
echo Obsidian启动脚本
echo ==========================================
echo.

for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion" /v ProgramFilesDir') do (
  set ProgramFilesPath=%%b
)
echo 默认Program Files目录: %ProgramFilesPath%

for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion" /v "ProgramFilesDir (x86)"') do (
  set ProgramFiles86Path=%%b
)
echo 默认Program Files (x86)目录: %ProgramFiles86Path%

for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion" /v "ProgramW6432Dir"') do (
  set ProgramW6432Dir=%%b
)
echo 默认Program W6432目录: %ProgramW6432Dir%

echo.
echo 第三步：修改Obsidian配置文件
echo ==========================================

set obsidianJsonPath=%APPDATA%\obsidian\obsidian.json
echo 检查配置文件: %obsidianJsonPath%

if exist "%obsidianJsonPath%" (
    echo [找到配置文件] 正在修改obsidian.json...
    
    REM 直接使用PowerShell修改文件，删除 ,"open":true
    powershell -Command "& {try { $content = Get-Content '%obsidianJsonPath%' -Raw -Encoding UTF8; $newContent = $content -replace ',\"open\":true', ''; $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False; [System.IO.File]::WriteAllText('%obsidianJsonPath%', $newContent, $Utf8NoBomEncoding); Write-Host '[成功] 配置文件已修改' } catch { Write-Host '[错误] 修改配置文件失败:' $_.Exception.Message }}"
) else (
    echo [警告] 未找到obsidian.json配置文件
)

echo.
echo 第四步：检查Obsidian安装路径
echo ==========================================

set pathCount=0
for %%i in (
    "%LOCALAPPDATA%\Obsidian\Obsidian.exe"
    "%ProgramFilesPath%\Obsidian\Obsidian.exe"
    "%ProgramFiles86Path%\Obsidian\Obsidian.exe"
    "%ProgramW6432Dir%\Obsidian\Obsidian.exe"
) do (
    set /a pathCount+=1
    echo 正在检查路径 !pathCount!: %%~i
    if exist "%%~i" (
        echo [成功找到] %%~i
        echo 即将启动Obsidian...
        start "" "%%~i"
        echo 启动命令已执行
        goto success
    ) else (
        echo [未找到] %%~i
    )
    echo.
)

echo.
echo 所有路径都未找到Obsidian
goto end

:success
echo.
echo ==========================================
echo 成功启动Obsidian！
echo ==========================================

:end
echo.
echo ==========================================
echo 脚本执行完毕
echo ==========================================
pause >nul
