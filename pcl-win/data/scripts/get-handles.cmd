@echo off


:start

title Get Open Handles

color 0d


cls
echo Task: Getting open handles....
md "%pclTempMain%\temp"


cls
echo Task: Getting open handles....
%getHandles%>"%pclTempMain%\temp\openHandles.txt"


cls
echo Task: Open "%pclTempMain%\temp\openHandles.txt"
notepad "%pclTempMain%\temp\openHandles.txt"



cls
echo New run? [Y/N]:
echo.
echo.
echo Type Y or N and press ENTER to choose
echo.
echo.

set /p newrun=

if %newrun%==y goto start
if %newrun%==Y goto start
if %newrun%==n goto end
if %newrun%==N goto end

:end

exit
