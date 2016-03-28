@echo off

set textBody=Body Text Here
set buttonStyle=0
set textTitle=Titlebar Text Here

set textBody=%1
set buttonStyle=%2
set textTitle=%3

set msgBoxVB=echo wscript.quit MsgBox

set ws=wscript //nologo
set outputScript="%pclTempMain%\temp\msgbox.vbs"

set ok=1
set cancel=2
set abort=3
set ignore=4
set cancel=5
set yes=6
set no=7

set rm=del /f /q

%msgBoxVB% ("%textBody%", %buttonStyle% , "%textTitle%") > %outputScript%

::pause

%ws% %outputScript%

set value=%errorlevel%

%rm% %outputScript%

if "%value%"=="%ok%" echo you clicked ok 
if "%value%"=="%cancel%" echo you clicked cancel
if "%value%"=="%abort%" echo you clicked abort
if "%value%"=="%ignore%" echo you clicked ignore
if "%value%"=="%cancel%" echo You clicked cancel
if "%value%"=="%yes%" echo You clicked yes
if "%value%"=="%no%" echo You clicked no

echo %value%
pause


exit
