@echo off

color 0b


set target=%1


:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)


:: Setting find commands
set listFiles=dir /b
set findExe=find "exe"
set pathTemp=%pclTempMain%\temp\
set results=%pclTempMain%\temp\exeFindResults.txt
set openText="%windir%\notepad.exe"



:autoDrop
cls

if not exist %pathTemp% md %pathTemp%

%listFiles% %target% | %findExe%>%results%
start "" %openText% "%results%"

goto end




:end

exit






