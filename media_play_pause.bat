@echo off
setlocal

if /I "%~1"=="-h" goto :help
if /I "%~1"=="--help" goto :help

set "SCRIPT_DIR=%~dp0"
set "PS1=%SCRIPT_DIR%send_media_key.ps1"

if not exist "%PS1%" (
  echo [ERROR] 找不到脚本："%PS1%"
  exit /b 1
)

REM 默认发送 Play/Pause；如传参则作为 Key 透传（例如 Next / Prev / 0xB3）
set "KEY=PlayPause"
if not "%~1"=="" set "KEY=%~1"

cmd /c start /min "" powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "%PS1%" -Key "%KEY%"
exit /b 0

:help
echo 用法:
echo   %~nx0                 ^(发送 Play/Pause 媒体键，隐藏运行^)
echo   %~nx0 Next            ^(下一曲^)
echo   %~nx0 Prev            ^(上一曲^)
echo   %~nx0 Stop            ^(停止^)
echo   %~nx0 0xB3            ^(直接指定 VK^)
exit /b 0
