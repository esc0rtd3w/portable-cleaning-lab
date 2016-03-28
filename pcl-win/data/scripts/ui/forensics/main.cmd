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

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set manualMenuMode=forensics

set uiMode=forensics
color 0e

set titleText=Forensics Mode :: portablecleaninglab.com
set bannerText=[OS: %ostype%/%bits%] [Safe Mode: %safeModeState%] [Network: %networkStatus%] [Mode: %uiMode%]

%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
echo.
%cocolor% 07
echo 1) Dump All Malware Location and Uninstall Entries From Registry
echo 2) Get Handles From All Current Open Applications
echo 3) Change Default Dump Path
echo 4) Transfer Data Dumps Back to Current Source Media (%rootDrive%\)
echo 5) Dump EXE Names From A Target Folder
echo.
%cocolor% 0a
echo 6) Show Running Services
echo 7) Show Active Network Connections
echo 8) Show Current Scheduled Tasks
echo.
%cocolor% 0d
echo 9) Tools and Utilities
echo.
%cocolor% 0b
echo BW) Build Whitelist From Current Machine
echo BB) Build Blacklist From Current Machine
echo BG) Build Greylist From Current Machine
echo.
echo.
%cocolor% 0e
echo B) Go Back
echo.
echo X) Exit This Window
echo.

set /p menuItem=

if [%menuItem%]==[] goto reset

if %menuItem%==B goto chkExit
if %menuItem%==b goto chkExit

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

if %menuItem%==bw goto listWhite
if %menuItem%==BW goto listWhite
if %menuItem%==Bw goto listWhite
if %menuItem%==bW goto listWhite

if %menuItem%==bb goto listBlack
if %menuItem%==BB goto listBlack
if %menuItem%==Bb goto listBlack
if %menuItem%==bB goto listBlack

if %menuItem%==bg goto listGrey
if %menuItem%==BG goto listGrey
if %menuItem%==Bg goto listGrey
if %menuItem%==bG goto listGrey

if %menuItem% gtr 9 goto reset

if %menuItem%==1 goto optionForensics1
if %menuItem%==2 goto optionForensics2
if %menuItem%==3 goto optionForensics3
if %menuItem%==4 goto optionForensics4
if %menuItem%==5 goto optionForensics5
if %menuItem%==6 goto optionForensics6
if %menuItem%==7 goto optionForensics7
if %menuItem%==8 goto optionForensics8
if %menuItem%==9 goto optionForensics9

goto reset


:optionForensics1

%runShellNoTerminate% "%pclScriptsPath%\dump-all-locations.cmd"

goto reset


:optionForensics2

%runShellNoTerminate% "%pclScriptsPath%\get-handles.cmd"

goto reset


:optionForensics3

%runShellNoTerminate% "%pclScriptsPath%\change-dump-path.cmd"

goto reset


:optionForensics4

%runShellNoTerminate% "%pclScriptsPath%\pull-dump-to-source.cmd"

goto reset


:optionForensics5

%runShellNoTerminate% "%pclScriptsPath%\get-exe-names.cmd"

goto reset


:optionForensics6

%runShellNoTerminate% "%pclUiPathForensics%\check-running-services.cmd"

goto reset


:optionForensics7

%runShellNoTerminate% "%pclUiPathForensics%\check-network-connections.cmd"

goto reset


:optionForensics8

%runShellNoTerminate% "%pclUiPathForensics%\check-current-tasks.cmd"

goto reset


:optionForensics9

call "%pclUiPathForensics%\tools-main.cmd"

goto reset


:listWhite

%runShellNoTerminate% "%pclUiPathForensics%\get-current-machine-whitelist.cmd"

goto reset


:listBlack

%runShellNoTerminate% "%pclUiPathForensics%\get-current-machine-blacklist.cmd"

goto reset


:listGrey

%runShellNoTerminate% "%pclUiPathForensics%\get-current-machine-greylist.cmd"

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

