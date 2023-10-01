@echo off
SETLOCAL

:: Check if the script is running with administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as an administrator.
    pause
    exit /b
)

:: Determine paths for the files
SET MTASC_BINARY=mtasc.exe
SET STD_DIRECTORY=std
SET STD8_DIRECTORY=std8

if exist bin\mtasc.exe (
    SET MTASC_BINARY=bin\mtasc.exe
    SET STD_DIRECTORY=bin\std
    SET STD8_DIRECTORY=bin\std8
)

:: Clean up previous installation
if exist "%ProgramFiles%\mtasc" (
    rmdir /s /q "%ProgramFiles%\mtasc"
)

:: Copy files
mkdir "%ProgramFiles%\mtasc"
copy "%MTASC_BINARY%" "%ProgramFiles%\mtasc\mtasc.exe"
xcopy /E /I "%STD_DIRECTORY%" "%ProgramFiles%\mtasc\std"
xcopy /E /I "%STD8_DIRECTORY%" "%ProgramFiles%\mtasc\std8"

:: Add to PATH (optional)
setx PATH "%PATH%;%ProgramFiles%\mtasc" /M

echo Installed into %ProgramFiles%\mtasc
"%ProgramFiles%\mtasc\mtasc.exe" --help

ENDLOCAL
