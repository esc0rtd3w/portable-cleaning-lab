@echo off

color 0b

:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)


:: Setting find commands
set listFiles=dir /b
set findWallpaper=find "exe"
set pathTemp=%pclTempMain%\temp\
set results=%pclTempMain%\temp\wpFindResults.txt
set openText="%windir%\notepad.exe"


if not exist %pathTemp% md %pathTemp%

set target=%windir%\Web\Wallpaper

::%listFiles% %target% | %findWallpaper%>%results%
%listFiles% "%target%">%results%
::start "" %openText% "%results%"

set dest=%pclTempMain%\wallpaper-thief\%username%

if not exist %dest% md %dest%

setlocal ENABLEDELAYEDEXPANSION

goto loop

:loop

set wpList=0
for /f "tokens=*" %%a in (%results%) do (
    set /a wpList=!wpList! + 1
    ::set var!wpList!=%%a
	xcopy /y /e /s /r /i "%target%\%%a\*" "%dest%\%%a"
	xcopy /y /e /s /r "%target%\*" "%dest%"
    if exist "%dest%\%%a" goto end
)
::set var


::goto loop


endlocal

:end

explorer "%dest%"





