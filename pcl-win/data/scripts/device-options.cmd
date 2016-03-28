@echo off

color 0a

set currentDevice=BLANK_ENTRY


:menuMain
color 0a

title %titleText%

cls
echo Current Device: %currentDevice%
echo.
echo.
echo Select a device option from below and press ENTER:
echo.
echo.
echo 1) Scan All Devices*
echo.
echo 2) Search For Device*
echo.
echo 3) Set Target Device*
echo.
echo 4) Install Device*
echo.
echo 5) Uninstall Device*
echo.
echo 6) Restart Device*
echo.
echo 7) Open Device Manager
echo.
echo 8) Other Options*
echo.
echo.
echo X) Exit Window
echo.
echo.

set /p deviceOption=

if [%deviceOption%]==[] goto menuMain

if %deviceOption%==X goto end
if %deviceOption%==x goto end

if %deviceOption% gtr 8 goto menuMain

if %deviceOption%==1 goto option1
if %deviceOption%==2 goto option2
if %deviceOption%==3 goto option3
if %deviceOption%==4 goto option4
if %deviceOption%==5 goto option5
if %deviceOption%==6 goto option6
if %deviceOption%==7 goto option7
if %deviceOption%==8 goto option8

goto menuMain


:option1



goto menuMain

:option2



goto menuMain

:option3



goto menuMain

:option4



goto menuMain

:option5



goto menuMain

:option6



goto menuMain

:option7

if %ostype%==xp start /d "%windir%\system32" devmgmt.msc

if %ostype%==vista "%windir%\system32\hdwwiz.cpl"
if %ostype%==win7 "%windir%\system32\hdwwiz.cpl"
if %ostype%==win8 "%windir%\system32\hdwwiz.cpl"
if %ostype%==win81 "%windir%\system32\hdwwiz.cpl"

goto menuMain

:option8



goto menuMain






:end


