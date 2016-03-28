@echo off

title Unlocker Auto Script

set unlock="%pclBinPath%\unlocker.exe"

color 05


setlocal ENABLEDELAYEDEXPANSION

goto loop

:loop

cls
echo Unlocking known baddies....
echo.
echo.
echo Proceed to run a taskkill loop or a remove directory loop.
echo.
echo.

set processList=0
for /f "tokens=*" %%a in (%list%) do (
    set /a processList=!processList! + 1
    ::set var!processList!=%%a
	%unlock% "%%a" /s
)
::set var


goto loop


endlocal



:end

