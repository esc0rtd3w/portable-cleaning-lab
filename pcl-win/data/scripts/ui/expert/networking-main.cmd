@echo off

:reset

%checkNetworkStatus%

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set titleText=Networking Tools and Scripts :: portablecleaninglab.com
%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
echo.
echo 1) Disable and Enable Default Wireless Connection
echo.
echo 2) Show Default Wireless Connection Info
echo.
echo.
echo 3) Fiddler (Live HTTP Debugger)
echo.
echo 4) Filezilla (Portable FTP Client)
echo.
echo 5) TeamViewer (Remote Connection To Client)
echo.
echo 6) Wireshark (Network Packet Capture)
echo.
echo.
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

if %menuItem% gtr 6 goto reset

if %menuItem%==1 call "%pclFixesScriptPath%\fix-wlan.cmd"
if %menuItem%==2 call "%pclNetworkScriptPath%\wlan\show-all-connections.cmd"
if %menuItem%==3 set moduleActive=fiddler
if %menuItem%==4 set moduleActive=filezilla
if %menuItem%==5 set moduleActive=teamviewer
if %menuItem%==6 set moduleActive=wireshark

if %menuItem%==1 goto reset
if %menuItem%==2 goto reset

set runDirectory=%pclTempMain%\%moduleActive%

goto runNetwork


:runNetwork
cls
echo Unpacking %moduleActive% module....
echo.
echo.

if exist "%pclTempMain%" %rmdir% "%pclTempMain%"
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

%pclExtractModule% "%pclModulesPath%\network\%moduleActive%.pcl" "%pclTempMain%"
call "%pclMenuPath%\network\fixes.cmd"
%runShellTerminateAndWait% "%runDirectory%\launch.cmd"

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

