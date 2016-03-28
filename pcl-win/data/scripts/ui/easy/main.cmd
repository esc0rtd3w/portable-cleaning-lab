@echo off

:reset

:: GUI USE ONLY
if exist "%windir%\temp\initGUI.txt" (
call "..\..\core\get-drive-root.cmd"
call "..\..\core\set-global.cmd"
)

::%checkNetworkStatus%

:: Check exitStatus before continuing
if %exitStatus%==back (
goto end
)
if %exitStatus%==close (
goto end
)

:: Recheck next available drive letter (added 20141201)
:: Solves issues when devices are connected after initial launch
%getNextAvailableDriveLetter%
%setNextAvailableDriveLetter%

set titleText=Portable Cleaning Lab v%mainVer% Easy Mode :: portablecleaninglab.com
title %titleText%

set uiMode=easy
set bannerText=[OS: %ostype%/%bits%] [Safe Mode: %safeModeState%] [Network: %networkStatus%] [Mode: %uiMode%]

:: Adding "Take Ownership" to context menu
:: Using individual reg files to control take ownership actions - added 20141011
%regImportFromFile% "%pclRegistryPath%\add-take-ownership-%ostype%.reg"

:: Default menu color
color 0e

:: Begin Main Menu (Easy Default)

:: Set menuItem to a high value before displaying each menu
set menuItem=999

%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
::echo %menuItem%
echo.
%cocolor% 0e
echo 1) Option 1
echo 2) Option 2
echo 3) Option 3
echo 4) Option 4
echo 5) Option 5
echo 6) Option 6
echo.
echo.
%cocolor% 0b
echo R) Reboot Options (Normal, Safe Mode, Restart Explorer, etc)
echo.
echo.
%cocolor% 0e
echo B) Go Back
echo.
echo X) Exit This Window
echo.

set /p menuItem=

if [%menuItem%]==[] goto reset

if %menuItem%==U goto chkUpdate
if %menuItem%==u goto chkUpdate

if %menuItem%==B goto chkExit
if %menuItem%==b goto chkExit

if %menuItem%==R goto optionMainR
if %menuItem%==r goto optionMainR

if %menuItem%==X goto chkExit
if %menuItem%==x goto chkExit

:: Fix for keyword returning back to main menu 20141117
:: If actually using the "menu" keyword then really do go back to main menu
:: Sets exitStatus as "menu" and goes to end of script, which returns to main PCL script 20141128
if %menuItem%==menu (
set exitStatus=ui
goto end
)
:: Use the init menuItem to return to the very beginning of the main PCL script
if %menuItem%==init (
set exitStatus=init
goto end
)
:: Use the reset menuItem to return to the reset label of the main PCL script
if %menuItem%==reset (
set exitStatus=reset
goto end
)

if exist "%pclKeywordsPath%\%menuItem%.cmd" (
%runShellNoTerminate% "%pclKeywordsPath%\%menuItem%.cmd"
%wait% 1
goto reset
)


if %menuItem% gtr 6 goto reset

if %menuItem%==1 goto optionMain1
if %menuItem%==2 goto optionMain2
if %menuItem%==3 goto optionMain3
if %menuItem%==4 goto optionMain4
if %menuItem%==5 goto optionMain5
if %menuItem%==6 goto optionMain6
goto reset


:chkUpdate

%checkForUpdates%

goto reset


:optionMain1

call "%pclUiPathEasy%\optionHere.cmd"

goto reset


:optionMain2

call "%pclUiPathEasy%\optionHere.cmd"

goto reset


:optionMain3

call "%pclUiPathEasy%\optionHere.cmd"

goto reset


:optionMain4

call "%pclUiPathEasy%\optionHere.cmd"

goto reset


:optionMain5

call "%pclUiPathEasy%\optionHere.cmd"

goto reset


:optionMain6

call "%pclUiPathEasy%\optionHere.cmd"

goto reset


:optionMainB

call "%pclMenuPath%\backup\main.cmd"

goto reset


:optionMainR

call "%pclMenuPath%\reboot\reboot-options.cmd"

goto reset


:chkExit

if %menuItem%==B set exitStatus=ui
if %menuItem%==b set exitStatus=ui

if %menuItem%==X set exitStatus=close
if %menuItem%==x set exitStatus=close

:: If an exitStatus is not set then set it to return as default
::if not defined exitStatus set exitStatus=return

if %exitStatus%==return goto reset

goto end



:end

