@echo off

color 0b


:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)



cls
%cocolor% 0b
echo Current Dump Path: %dumpPath%
echo.
%cocolor% 0e
echo Set New Dump Path and Press ENTER:
echo.
echo DO NOT USE QUOTES! THEY WILL BE ADDED AUTOMATICALLY IF NEEDED!
echo.
echo.
set /p dumpPath=

if not exist "%dumpPath%" md "%dumpPath%"

echo %dumpPath%>"%pclTempMain%\dump.path"


:end

exit



