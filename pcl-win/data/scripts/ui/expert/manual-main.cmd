@echo off

:reset

:: Check exitStatus before continuing
if %exitStatus%==back (
goto end
)
if %exitStatus%==close (
goto end
)

%checkNetworkStatus%

:: Recheck next available drive letter (added 20141201)
:: Solves issues when devices are connected after initial launch
%getNextAvailableDriveLetter%
%setNextAvailableDriveLetter%

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set manualMenuMode=normal

set uiMode=expert
color 0e

set titleText=Manual Malware Removal :: portablecleaninglab.com
set bannerText=[OS: %ostype%/%bits%] [Safe Mode: %safeModeState%] [Network: %networkStatus%] [Mode: %uiMode%]
%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
echo.
if %counterStatus%==on %cocolor% 0a
if %counterStatus%==off %cocolor% 0c
echo Z) Toggle Counter "ON"       z) Toggle Counter "OFF"
echo.
echo.
%cocolor% 0d
echo 1) Unlock and Remove Active and Stubborn Files
echo.
%cocolor% 0a
echo 2) Run a Browser Kill Loop
echo 3) Run a Baddie Kill Loop
echo.
%cocolor% 0b
echo 4) Run a Baddie Service Removal Loop
echo 5) Run a Baddie Tasks Removal Loop
echo 6) Run a Baddie Uninstall Loop
echo 7) Run a Baddie Uninstall MSI Loop
echo 8) Run a Baddie Remove Directory Loop
echo 9) Run a Baddie Registry Cleaning Loop
echo.
%cocolor% 0e
echo 10) Open Common Folders To Check Manually
echo 11) Browse Other Scripts and Tweaks To Aid In Cleanup
echo.
%cocolor% 0a
echo U) Open a User Command Prompt
echo A) Open an Administrator Command Prompt
echo S) Open a System Command Prompt
echo.
echo.
%cocolor% 0e
echo B) Go Back
echo.
echo X) Exit This Window
echo.

set /p menuItem=

if [%menuItem%]==[] goto reset

if %menuItem%==Z goto counterToggleOn
if %menuItem%==z goto counterToggleOff

if %menuItem%==B goto chkExit
if %menuItem%==b goto chkExit

if %menuItem%==U goto optCMDNRM
if %menuItem%==u goto optCMDNRM

if %menuItem%==A goto optCMDADM
if %menuItem%==a goto optCMDADM

if %menuItem%==S goto optCMDSYS
if %menuItem%==s goto optCMDSYS

if %menuItem%==X goto chkExit
if %menuItem%==x goto chkExit

if %menuItem% gtr 11 goto reset

if %menuItem%==1 goto optionManual1
if %menuItem%==2 goto optionManual2
if %menuItem%==3 goto optionManual3
if %menuItem%==4 goto optionManual4
if %menuItem%==5 goto optionManual5
if %menuItem%==6 goto optionManual6
if %menuItem%==7 goto optionManual7
if %menuItem%==8 goto optionManual8
if %menuItem%==9 goto optionManual9
if %menuItem%==10 goto optionManual10
if %menuItem%==11 goto optionManual11

goto reset


:optionManual1

%runShellNoTerminate% "%pclScriptsPath%\unlock-manual.cmd"

goto reset


:optionManual2

%runShellNoTerminate% "%pclScriptsPath%\browser-loop.cmd"

goto reset


:optionManual3

%runShellNoTerminate% "%pclScriptsPath%\tkloop.cmd"

goto reset


:optionManual4

%runShellNoTerminate% "%pclScriptsPath%\services-loop.cmd"

goto reset


:optionManual5

%runShellNoTerminate% "%pclScriptsPath%\tasks-loop.cmd"

goto reset


:optionManual6

%runShellNoTerminate% "%pclScriptsPath%\uninstall-loop.cmd"

goto reset


:optionManual7

%runShellNoTerminate% "%pclScriptsPath%\uninstall-loop-msi.cmd"

goto reset


:optionManual8

if %counterStatus%==on %runShellNoTerminate% "%pclScriptsPath%\rmloop-counter.cmd"
if %counterStatus%==off %runShellNoTerminate% "%pclScriptsPath%\rmloop.cmd"

goto reset


:optionManual9

cls
echo Removing ALL Known Baddies From The Windows Registry....
echo.
echo.

%regImportFromFile% "%pclRegistryPath%\fixes\multi-malware-reg-fix.reg"
%runShellNoTerminate% "%pclScriptsPath%\reg-loop.cmd"


goto reset


:optionManual10

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set titleText=Manual Malware Removal - Open Directories :: portablecleaninglab.com
%bannerMenuDefault%

echo Choose an directory to open and press ENTER:
echo.
echo.
echo 1) %pf%
if %bits%==x86 %cocolor% 0c
echo 2) %pf64%
%cocolor% 0e
echo 3) %cf%
if %bits%==x86 %cocolor% 0c
echo 4) %cf64%
%cocolor% 0e
echo 5) %pd%
echo 6) %userdir%
echo 7) %mydocuments%
echo 8) %mydownloads%
echo 9) %adl%
echo 10) %adll%
echo 11) %adr%
echo 12) %tempDirectory%
echo 13) %win%
echo 14) %sys32%
echo 15) %sysprofile%
echo 16) %temp2%
echo 17) %temp3%
echo 18) %temp4%
echo 19) %sysUserAppDataLocal%
echo 20) %sysUserAppDataLocalLow%
echo 21) %sysUserAppDataRoaming%
echo 22) %cookies%
echo.
echo.
echo B) Go Back
echo.
echo X) Exit This Window
echo.

set /p menuItem=

if [%menuItem%]==[] goto optionManual10

if %menuItem%==B goto reset
if %menuItem%==b goto reset

if %menuItem%==X goto chkExit
if %menuItem%==x goto chkExit

if %menuItem% gtr 22 goto optionManual10

if %menuItem%==1 %openFolder% "%pf%"
if %menuItem%==2 (if %bits%==x64 %openFolder% "%pf64%")
if %menuItem%==3 %openFolder% "%cf%"
if %menuItem%==4 (if %bits%==x64 %openFolder% "%cf64%")
if %menuItem%==5 %openFolder% "%pd%"
if %menuItem%==6 %openFolder% "%userdir%"
if %menuItem%==7 %openFolder% "%documents%"
if %menuItem%==8 %openFolder% "%mydownloads%"
if %menuItem%==9 %openFolder% "%adl%"
if %menuItem%==10 %openFolder% "%adll%"
if %menuItem%==11 %openFolder% "%adr%"
if %menuItem%==12 %openFolder% "%tempDirectory%"
if %menuItem%==13 %openFolder% "%win%"
if %menuItem%==14 %openFolder% "%sys32%"
if %menuItem%==15 %openFolder% "%sysprofile%"
if %menuItem%==16 %openFolder% "%temp2%"
if %menuItem%==17 %openFolder% "%temp3%"
if %menuItem%==18 %openFolder% "%temp4%"
if %menuItem%==19 %openFolder% "%sysUserAppDataLocal%"
if %menuItem%==20 %openFolder% "%sysUserAppDataLocalLow%"
if %menuItem%==21 %openFolder% "%sysUserAppDataRoaming%"
if %menuItem%==22 %openFolder% "%cookies%"

goto optionManual10


:optionManual11

%checkNetworkStatus%

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set itemMax=18

set titleText=Manual Malware Removal - Other Fixes :: portablecleaninglab.com
%bannerMenuDefault%

echo Choose an option and press ENTER:
echo.
echo.
echo 1) Purge All System Restore Points
echo 2) Purge All Scheduled Tasks
echo 3) Purge Taskbar Notification Icon Cache
echo 4) Purge Custom
echo.
%cocolor% 0d
echo 5) Reset Internet Explorer To Default
echo 6) Enable Windows Task Manager
echo 7) Run a System File Checker Scan (SFC /scannow)
echo.
%cocolor% 0a
echo 8) Backup Run and RunOnce Registry Locations
echo 9) Clean Run and RunOnce Registry Locations
echo 10) Restore Run and RunOnce Registry Locations
echo.
%cocolor% 0c
echo 11) Reset ACL Permissions for Administrator Group
echo 12) Reset Owner To Current User
echo.
%cocolor% 09
echo 13) Launch MSConfig (Startup and Service Config)
echo 14) Launch DirectX Diagnostic Tool
echo 15) Launch Services.msc (Configure Services)
echo 16) Launch Windows Task Manager
echo.
%cocolor% 07
echo 17) View/Edit HOSTS File
echo 18) View Windows Event Logs
echo 19) Disable Windows 10 GWX Nags (Win7, 8, 8.1 Only)

:: Check OS for displaying GWX Nag removal
::set osflag=0

::if %ostype%==win7 set osflag=1
::if %ostype%==win8 set osflag=1
::if %ostype%==win81 set osflag=1

::if %osflag%==1 set itemMax=19
::if %osflag%==1 echo 19) Disable Windows 10 GWX Nags

echo.
echo.
%cocolor% 0e
echo B) Go Back
echo.
echo X) Exit This Window
echo.

set /p menuItem=

if [%menuItem%]==[] goto optionManual11

if %menuItem%==B goto reset
if %menuItem%==b goto reset

if %menuItem%==X goto chkExit
if %menuItem%==x goto chkExit

if %menuItem% gtr 19 goto optionManual11


if %menuItem%==1 %runShellNoTerminate% "%pclScriptsPath%\purge-restore-points-all.cmd"
if %menuItem%==2 %runShellNoTerminate% "%pclScriptsPath%\clear-tasks.cmd"
if %menuItem%==3 %runShellNoTerminate% "%pclScriptsPath%\purge-notification-cache.cmd"
if %menuItem%==4 %runShellNoTerminate% "%pclScriptsPath%\purge-custom.cmd"
if %menuItem%==5 %runShellNoTerminate% "%pclScriptsPath%\reset-to-default-ie9.cmd"
if %menuItem%==6 %regImportFromFile% "%pclRegistryPath%\enable-task-manager.reg"
if %menuItem%==7 %runShellNoTerminate% "%pclScriptsPath%\sfc-scan.cmd"
if %menuItem%==8 %runShellNoTerminate% "%pclScriptsPath%\reg-run-backup.cmd"
if %menuItem%==9 %runShellNoTerminate% "%pclScriptsPath%\reg-run-clean.cmd"
if %menuItem%==10 %runShellNoTerminate% "%pclScriptsPath%\reg-run-restore.cmd"
if %menuItem%==11 %runShellNoTerminate% "%pclScriptsPath%\reset-acl-perms.cmd"
if %menuItem%==12 goto resetOwner
if %menuItem%==13 start "" msconfig
if %menuItem%==14 start "" dxdiag
if %menuItem%==15 start "" services.msc
if %menuItem%==16 start "" taskmgr
if %menuItem%==17 %showText% "%systemroot%\system32\drivers\etc\HOSTS"
if %menuItem%==18 "%SystemRoot%\System32\events.exe"
if %menuItem%==19 %runShellNoTerminate% "%pclScriptsPath%\disable-gwx.cmd"

goto optionManual11


:optCMDNRM

%runShellNoTerminate%

goto reset

:optCMDADM

%bannerMenuDefault%

echo If you have a BLANK password set for administrator, THIS WILL FAIL!!!
echo.
echo.
%wait% 5
echo.
echo.
%runAsAdministrator% "%runShellNoTerminate%"

goto reset


:optCMDSYS

%bannerMenuDefault%

::%psexecElevateToSystem%
%runShellNoTerminate% "%pclScriptsPath%\core\elevate-privs-to-system.cmd"

goto reset


:resetOwner

%bannerMenuDefault%

%cp2% "%pclScriptsPath%\reset-owner.cmd" "%pclTempTemp%"
%runShellTerminate% "%pclTempTemp%\reset-owner.cmd"

%bannerMenuDefault%

echo Was the first method successful? [Y/N]:
echo.
echo Type Y or N and press ENTER
echo.

set /p resetAttemptOne=

if %resetAttemptOne%==Y goto optionManual11
if %resetAttemptOne%==y goto optionManual11

%cp2% "%pclScriptsPath%\reset-owner-alt.cmd" "%pclTempTemp%"
%runShellTerminate% "%pclTempTemp%\reset-owner-alt.cmd"

goto optionManual11


:counterToggleOn

set counterStatus=on

if %manualMenuMode%==normal call "%pclUiPathExpert%\manual-main.cmd"
if %manualMenuMode%==forensics %uiModeForensics%

:: Failsafe to return to Normal Manual Menu
goto reset

:counterToggleOff

set counterStatus=off

if %manualMenuMode%==normal call "%pclUiPathExpert%\manual-main.cmd"
if %manualMenuMode%==forensics %uiModeForensics%

:: Failsafe to return to Normal Manual Menu
goto reset


:chkExit

if %menuItem%==B set exitStatus=back
if %menuItem%==b set exitStatus=back

if %menuItem%==X set exitStatus=close
if %menuItem%==x set exitStatus=close

:: If an exitStatus is not set then set it to return as default
::if not defined exitStatus set exitStatus=return

::if %exitStatus%==return goto reset

goto end


:end

