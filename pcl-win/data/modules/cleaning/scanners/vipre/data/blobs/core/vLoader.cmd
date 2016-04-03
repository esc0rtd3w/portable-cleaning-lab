@echo off

::echo Current Directory cd: %cd%
::echo Current Directory dp0: %~dp0
::pause

set cd=%~dp0

::echo Current Directory cd: %cd%
::echo Current Directory dp0: %~dp0
::pause

cd %cd%

::dir /b

::pause

color 0e

cls
echo Using vLoader to Launch Vipre Rescue Scanner....
echo.
echo.
echo This window can be safely closed after scanner has launched!
echo.
echo.
::"%~dp0VipreRescueScanner.exe"
start "" /d "%~dp0" "vLoader.exe"

exit