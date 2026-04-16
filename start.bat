@echo off
chcp 65001 >nul
title Smoke Patrol - 烟量巡逻官 (端口 8089)

echo.
echo  ★ SMOKE PATROL ★  烟量巡逻官
echo  ================================
echo  正在启动本地服务器...
echo.

:: 检查端口是否被占用，如果占用则先提示
netstat -ano | findstr ":8089 " >nul 2>&1
if %errorlevel%==0 (
    echo  [!] 端口 8089 已被占用，尝试关闭旧进程...
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8089 " ^| findstr "LISTENING"') do (
        taskkill /PID %%a /F >nul 2>&1
    )
    timeout /t 1 >nul
)

:: 自动打开浏览器
start http://localhost:8089

:: 用 Python 启动 HTTP 服务器
echo  浏览器已打开: http://localhost:8089
echo  按 Ctrl+C 可关闭服务器
echo.
python -m http.server 8089 --bind 127.0.0.1
pause
