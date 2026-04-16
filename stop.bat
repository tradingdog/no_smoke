@echo off
chcp 65001 >nul
title Smoke Patrol - 停止服务

echo.
echo  ★ SMOKE PATROL ★  烟量巡逻官
echo  ================================
echo  正在停止本地服务器 (端口 8089)...
echo.

set "found=0"
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8089 " ^| findstr "LISTENING"') do (
    taskkill /PID %%a /F >nul 2>&1
    set "found=1"
    echo  [OK] 已终止进程 PID: %%a
)

if "%found%"=="0" (
    echo  [!] 未发现运行在端口 8089 的服务
) else (
    echo.
    echo  服务已停止！
)

echo.
pause
