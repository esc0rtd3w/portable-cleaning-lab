@echo off

color 0b


:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)



:: Temp fix for inactive script
goto end

setlocal ENABLEDELAYEDEXPANSION

:: Program Files
color 0b
set listPF=%~dp0lists\uninstallPF.txt
for /f "tokens=*" %%a in (%listPF%) do (
    set /a listPF=!listPF! + 1
    set var!listPF!=%%a
	echo "%pf%\%%a"
	"%pf%\%%a"
)


:loopdone

endlocal


goto dowork


:end





