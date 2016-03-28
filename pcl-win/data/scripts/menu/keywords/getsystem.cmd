@echo off

mode con lines=33

color 0b

set current=%~dp0
pushd ..
set newRoot=%cd%
popd



set scriptPath="%newRoot%\pcl-win\data\scripts\core\elevate-pcl-to-system.cmd"
::echo %scriptPath:\\=\%
set scriptPath=%scriptPath:\\=\%
::echo %scriptPath%

set launchTimer=10

cls
%cocolor% 0c
echo This mode is BROKEN!
echo.
echo.
%cocolor% 0b
echo A new window will be spawned with SYSTEM privileges
echo.
echo You may close the previous one if needed!
echo.
echo.
echo.
%cocolor% 0e
echo The following things may not work:
echo.
echo.
echo 1) Modules DO NOT load properly for scanners and tools
echo.
echo 2) Menu items for scanners, utilities, and other tools
echo.
echo 3) Other menu items and scripts may not work
echo.
echo.
echo.
%cocolor% 0a
echo CLOSING THIS WINDOW IN %launchTimer% SECONDS....
echo.
echo.

%wait% %launchTimer%

call %scriptPath%


exit