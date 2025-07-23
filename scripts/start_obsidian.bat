@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1

REM 修改Obsidian配置文件
set obsidianJsonPath=%APPDATA%\obsidian\obsidian.json
if exist "%obsidianJsonPath%" (
    powershell -Command "& {try { $content = Get-Content '%obsidianJsonPath%' -Raw -Encoding UTF8; $newContent = $content -replace ',\"open\":true', ''; $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False; [System.IO.File]::WriteAllText('%obsidianJsonPath%', $newContent, $Utf8NoBomEncoding) } catch { }}" >nul 2>&1
)

for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion" /v ProgramFilesDir 2^>nul') do (
  set ProgramFilesPath=%%b
)

for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion" /v "ProgramFilesDir (x86)" 2^>nul') do (
  set ProgramFiles86Path=%%b
)

for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion" /v "ProgramW6432Dir" 2^>nul') do (
  set ProgramW6432Dir=%%b
)

for %%i in (
    "%LOCALAPPDATA%\Obsidian\Obsidian.exe"
    "%ProgramFilesPath%\Obsidian\Obsidian.exe"
    "%ProgramFiles86Path%\Obsidian\Obsidian.exe"
    "%ProgramW6432Dir%\Obsidian\Obsidian.exe"
) do (
    if exist "%%~i" (
        start "" "%%~i"
        goto end
    )
)

where obsidian.exe >nul 2>&1
if not errorlevel 1 (
    start "" obsidian.exe
)

:end
