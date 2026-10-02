@echo off
title SysForge - Windows Diagnostic & Maintenance Toolkit
color 07

:MENU
cls

echo ==========================================
echo              SYSFORGE
echo    Windows Diagnostic ^& Maintenance
echo ==========================================
echo.
echo [1] Diagnostico rapido
echo [2] Diagnostico de rede
echo [3] Reparar Windows
echo [4] Limpeza basica
echo [5] Informacoes do sistema
echo [6] Processos e desempenho
echo [7] Programas de inicializacao
echo [8] Servicos do Windows
echo [9] Gerar relatorio
echo.
echo [0] Sair
echo.

set /p opcao="Escolha uma opcao: "

if "%opcao%"=="1" goto DIAGNOSTICO
if "%opcao%"=="2" goto REDE
if "%opcao%"=="3" goto REPARAR
if "%opcao%"=="4" goto LIMPEZA
if "%opcao%"=="5" goto SISTEMA
if "%opcao%"=="6" goto DESEMPENHO
if "%opcao%"=="7" goto INICIALIZACAO
if "%opcao%"=="8" goto SERVICOS
if "%opcao%"=="9" goto RELATORIO
if "%opcao%"=="0" exit

echo.
echo Opcao invalida.
pause
goto MENU


:DIAGNOSTICO
cls
powershell -ExecutionPolicy Bypass -File "%~dp0modules\diagnostico.ps1"
pause
goto MENU

:REDE
echo Diagnostico de rede
pause
goto MENU

:REPARAR
echo Reparar Windows
pause
goto MENU

:LIMPEZA
echo Limpeza basica
pause
goto MENU

:SISTEMA
echo Informacoes do sistema
pause
goto MENU

:DESEMPENHO
echo Processos e desempenho
pause
goto MENU

:INICIALIZACAO
echo Programas de inicializacao
pause
goto MENU

:SERVICOS
echo Servicos do Windows
pause
goto MENU

:RELATORIO
echo Gerar relatorio
pause
goto MENU