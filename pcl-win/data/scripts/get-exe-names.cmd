@echo off

color 0b


:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)


:: Setting find commands
set listFiles=dir /b
set findExe=find "exe"
set pathTemp=%pclTempMain%\temp\
set results=%pclTempMain%\temp\exeFindResults.txt
set openText="%windir%\notepad.exe"



:doWork

color 0b

cls
echo This will pull all EXE names from a directory and output to a text file.
echo.
echo.
echo Drop a folder into this window or type the path and press ENTER:
echo.
echo.

set /p target=

if not exist %pathTemp% md %pathTemp%

%listFiles% %target% | %findExe%>%results%
start "" %openText% "%results%"

goto dowork





:end





