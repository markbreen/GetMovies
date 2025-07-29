@echo off
:: GetMovies V2.0 Launcher
:: Retro Torrent Search Application
echo.
echo ===============================================
echo        GETMOVIES V2.0 - RETRO EDITION
echo          TORRENT SEARCH APPLICATION
echo ===============================================
echo.
echo Starting GetMovies maximized...
echo.

:: Use start command with /MAX flag
start "GetMovies V2.0" /MAX powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0GetMoviesV2_Retro.ps1"

:: Wait a moment then exit the batch file
timeout /t 2 /nobreak >nul
