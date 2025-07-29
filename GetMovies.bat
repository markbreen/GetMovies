@echo off
:: GetMovies V2.0 Launcher
:: Retro Torrent Search Application

echo.
echo ===============================================
echo        GETMOVIES V2.0 - RETRO EDITION
echo          TORRENT SEARCH APPLICATION
echo ===============================================
echo.
echo Starting GetMovies...
echo.

:: Run the PowerShell script with appropriate execution policy
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0GetMoviesV2_Retro.ps1"

:: Pause if there was an error
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Failed to start GetMovies!
    echo Please ensure PowerShell is installed and working.
    echo.
    pause
)