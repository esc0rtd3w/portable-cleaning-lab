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

set titleText=Portable Cleaning Lab v%mainVer% Expert Mode :: portablecleaninglab.com
title %titleText%

set uiMode=expert
set bannerText=[OS: %ostype%/%bits%] [Safe Mode: %safeModeState%] [Network: %networkStatus%] [Mode: %uiMode%]

:: Adding "Take Ownership" to context menu
:: Using individual reg files to control take ownership actions - added 20141011
%regImportFromFile% "%pclRegistryPath%\add-take-ownership-%ostype%.reg"
color 0e

if exist "%pclTempMain%\inject.off" set inject=0
if exist "%pclTempMain%\inject.on" set inject=1

if %inject%==0 set injectStatus=OFF
if %inject%==1 set injectStatus=ON

:: Begin Main Menu (Expert Default)

:: Set menuItem to a high value before displaying each menu
set menuItem=999

%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
::echo %menuItem%
echo.
%cocolor% 0e
echo 1) Manual Malware Removal (Baddie Removal Loops, Fixes, Scripts, etc)
echo.
echo 2) Choose a Malware/Virus Scanner To Use
echo 3) Choose a Rootkit/Other Scanner To Use
echo 4) A/V Cleaners (Remove Installed Antivirus)
echo.
echo 5) Choose a Diagnostic Tool To Use
echo 6) Choose a Maintenance Tool To Use
echo 7) Choose a Recovery Tool To Use
echo 8) Choose a Utility To Use
echo.
echo 9) Networking Tools and Scripts
echo.
echo T) Clean Current Temp Folders
echo.
echo.
echo.
%cocolor% 03
echo W) Web Browser Manager (Install, Uninstall, Configure, Clean, etc)*
echo.
%cocolor% 0a
echo B) Backup User Data (Documents, Pictures, Desktop, Music, Videos, etc)
echo.
%cocolor% 0b
echo C) Clone PCL To Another Destination Device (Source Media to Any Media)
echo.
%cocolor% 0b
echo U) Check For PCL Updates (Core and Config Files, Modules, Scripts, etc)
echo.
%cocolor% 0c
echo R) Reboot Options (Normal, Safe Mode, Restart Explorer, etc)
echo.
%cocolor% 0d
echo H) Help / About
echo.
echo.
echo.
%cocolor% 0e
echo X) Exit This Window
echo.

set /p menuItem=

if [%menuItem%]==[] goto reset

if %menuItem%==U goto chkUpdate
if %menuItem%==u goto chkUpdate

if %menuItem%==W %runShellNoTerminate% "%pclScriptsPath%\browser-manager.cmd"
if %menuItem%==w %runShellNoTerminate% "%pclScriptsPath%\browser-manager.cmd"

if %menuItem%==B goto optionMainB
if %menuItem%==b goto optionMainB

if %menuItem%==C goto optionMainC
if %menuItem%==c goto optionMainC

if %menuItem%==R goto optionMainR
if %menuItem%==r goto optionMainR

if %menuItem%==H goto optionMainH
if %menuItem%==h goto optionMainH

if %menuItem%==T goto optionMainT
if %menuItem%==t goto optionMainT

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

:: Fix keyword menu items 20141117
::echo "%pclScriptsPath%\menu\keywords\%menuItem%.cmd"
if exist "%pclKeywordsPath%\%menuItem%.cmd" (
%runShellNoTerminate% "%pclKeywordsPath%\%menuItem%.cmd"
%wait% 1
	if %menuItem%==modulepath (
	set /p pclModulesPath=<%pclModulesPathEdit%
	set /p pclModulesCleaningScannersPath=<%pclModulesCleaningScannersPathEdit%
	)
goto reset
)


if %menuItem% gtr 9 goto reset

if %menuItem%==1 goto optionMain1
if %menuItem%==2 goto optionMain2
if %menuItem%==3 goto optionMain3
if %menuItem%==4 goto optionMain4
if %menuItem%==5 goto optionMain5
if %menuItem%==6 goto optionMain6
if %menuItem%==7 goto optionMain7
if %menuItem%==8 goto optionMain8
if %menuItem%==9 goto optionMain9
if %menuItem%==10 goto optionMain10
if %menuItem%==11 goto optionMain11
goto reset


:chkUpdate

%checkForUpdates%

goto reset


:optionMain1

call "%pclUiPathExpert%\manual-main.cmd"

goto reset


:optionMain2

call "%pclUiPathExpert%\scanners-main.cmd"

goto reset


:optionMain3

call "%pclUiPathExpert%\scanners-other.cmd"

goto reset


:optionMain4

call "%pclUiPathExpert%\avclean-main.cmd"

goto reset


:optionMain5

call "%pclUiPathExpert%\diag-main.cmd"

goto reset


:optionMain6

call "%pclUiPathExpert%\maint-main.cmd"

goto reset


:optionMain7

call "%pclUiPathExpert%\recovery-main.cmd"

goto reset


:optionMain8

call "%pclUiPathExpert%\utilities-main.cmd"

goto reset


:optionMain9

call "%pclUiPathExpert%\networking-main.cmd"

goto reset


:optionMainT

set cookiechop=y
set doChop=0
cls
echo Clean Cookies (Default Is YES)? [Y/N]:
echo.
set /p cookiechop=
if "%cookiechop%"=="" goto optionMain9
if %cookiechop%==Y call "%pclUiPathExpert%\cookie-cutter.cmd"
if %cookiechop%==y call "%pclUiPathExpert%\cookie-cutter.cmd"
call "%pclUiPathExpert%\clean-all-temp.cmd"

goto reset


:optionMainB

call "%pclMenuPath%\backup\main.cmd"

goto reset


:optionMainR

call "%pclMenuPath%\reboot\reboot-options.cmd"

goto reset


:optionMainC

call "%pclUiPathExpert%\clone-pcl.cmd"

goto reset


:optionMainH

%msgbox% %msgHelpMain%
%runShellNoTerminate% "%pclHelpPath%\main.cmd"

goto reset


:chkExit

if %menuItem%==B set exitStatus=back
if %menuItem%==b set exitStatus=back

if %menuItem%==X set exitStatus=close
if %menuItem%==x set exitStatus=close

:: If an exitStatus is not set then set it to return as default
::if not defined exitStatus set exitStatus=return

if %exitStatus%==return goto reset

goto end



:end

