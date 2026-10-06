@echo off

:: Verifica se o SysForge esta sendo executado como administrador

net session >nul 2>&1

if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

title SysForge - Windows Diagnostic ^& Maintenance Toolkit
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
echo [3] Reparar rede
echo [4] Reparar Windows
echo [5] Limpeza basica
echo [6] Informacoes do sistema
echo [7] Processos e desempenho
echo [8] Programas de inicializacao
echo [9] Servicos do Windows
echo [10] Gerar relatorio
echo.
echo [0] Sair
echo.

set /p opcao="Escolha uma opcao: "

if "%opcao%"=="1" goto DIAGNOSTICO
if "%opcao%"=="2" goto REDE
if "%opcao%"=="3" goto REPARAR_REDE
if "%opcao%"=="4" goto REPARAR
if "%opcao%"=="5" goto LIMPEZA
if "%opcao%"=="6" goto SISTEMA
if "%opcao%"=="7" goto DESEMPENHO
if "%opcao%"=="8" goto INICIALIZACAO
if "%opcao%"=="9" goto SERVICOS
if "%opcao%"=="10" goto RELATORIO
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
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\rede.ps1"

pause
goto MENU


:REPARAR_REDE
cls

echo ==========================================
echo              REPARAR REDE
echo ==========================================
echo.
echo [1] Limpar cache DNS
echo [2] Renovar endereco IP
echo [3] Resetar Winsock
echo [4] Resetar o TCP/IP
echo.
echo [0] Voltar
echo.

set /p reparoRede="Escolha uma opcao: "

if "%reparoRede%"=="1" goto FLUSHDNS
if "%reparoRede%"=="2" goto RENEWIP
if "%reparoRede%"=="3" goto WINSOCK
if "%reparoRede%"=="4" goto TCPIP
if "%reparoRede%"=="0" goto MENU

echo.
echo Opcao invalida.
pause
goto REPARAR_REDE


:FLUSHDNS
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\reparar-rede.ps1" flushdns

pause
goto REPARAR_REDE


:RENEWIP
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\reparar-rede.ps1" renewip

pause
goto REPARAR_REDE


:WINSOCK
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\reparar-rede.ps1" winsock

pause
goto REPARAR_REDE

:TCPIP
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\reparar-rede.ps1" tcpip

pause
goto REPARAR_REDE

:REPARAR
cls

echo ==========================================
echo            REPARAR WINDOWS
echo ==========================================
echo.
echo [1] Verificar arquivos do sistema (SFC)
echo [2] Reparar imagem do Windows (DISM)
echo.
echo [0] Voltar
echo.

set /p reparo="Escolha uma opcao: "

if "%reparo%"=="1" goto SFC
if "%reparo%"=="2" goto DISM
if "%reparo%"=="0" goto MENU

echo.
echo Opcao invalida.
pause
goto REPARAR


:SFC
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\reparar.ps1" SFC

pause
goto REPARAR


:DISM
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\reparar.ps1" DISM

pause
goto REPARAR


:LIMPEZA
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\limpeza.ps1"

pause
goto MENU


:SISTEMA
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\sistema.ps1"

pause
goto MENU


:DESEMPENHO
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\desempenho.ps1"

pause
goto MENU


:INICIALIZACAO
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\inicializacao.ps1"

pause
goto MENU


:SERVICOS
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\servicos.ps1"

pause
goto MENU


:RELATORIO
cls

powershell -ExecutionPolicy Bypass -File "%~dp0modules\relatorio.ps1"

pause
goto MENU