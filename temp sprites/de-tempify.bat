@echo off
setlocal enabledelayedexpansion

:: Change to the folder where the script is located
cd /d "%~dp0"

echo Renaming all .png files starting with "temp "...

:: Loop through all .png files recursively
for /r %%F in (*.png) do (
    set "fullpath=%%~fF"
    set "filename=%%~nxF"
    set "folder=%%~dpF"

    call :CheckAndRename "%%~fF" "%%~nxF"
)

echo Done.
pause
exit /b

:CheckAndRename
set "filepath=%~1"
set "name=%~2"

:: Check if filename starts with "temp "
echo %name% | findstr /b /c:"temp " >nul
if %errorlevel%==0 (
    setlocal enabledelayedexpansion
    set "name=%~2"
    set "newname=!name:~5!"
    echo Renaming "%name%" to "!newname!" in "%~dp1"
    ren "%~1" "!newname!"
    endlocal
)
exit /b
