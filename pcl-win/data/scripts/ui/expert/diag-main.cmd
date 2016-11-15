@echo off


:reset

%checkNetworkStatus%

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set titleText=Diagnostic Tools :: portablecleaninglab.com
%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
echo.
echo 1) CoreTemp
echo 2) Fake Flash Test (USB Flash Media Size Verification)
echo 3) HDDScan
echo 4) Install Spy
echo 5) OverDisk
echo 6) Process Explorer
echo 7) Process Hacker
echo 8) Process Monitor
echo 9) RegDllView
echo 10) RegFromApp
echo 11) RegScanner
echo 12) Seagate SeaTools
echo 13) Speccy
echo 14) svchost Analyzer
echo 15) System Explorer
echo 16) Unknown Device Identifier
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

if %menuItem% gtr 15 goto reset

if %menuItem%==1 set diagActive=core-temp
if %menuItem%==2 set diagActive=fakeflashtest
if %menuItem%==3 set diagActive=hddscan
if %menuItem%==4 set diagActive=install-spy
if %menuItem%==5 set diagActive=over-disk
if %menuItem%==6 set diagActive=process-explorer
if %menuItem%==7 set diagActive=process-hacker
if %menuItem%==8 set diagActive=process-monitor
if %menuItem%==9 set diagActive=regdllview
if %menuItem%==10 set diagActive=regfromapp
if %menuItem%==11 set diagActive=regscanner
if %menuItem%==12 set diagActive=seatools
if %menuItem%==13 set diagActive=speccy
if %menuItem%==14 set diagActive=svchost-analyzer
if %menuItem%==15 set diagActive=system-explorer
if %menuItem%==16 set diagActive=unknown-device-identifier

set runDirectory=%pclTempMain%\%diagActive%

goto runDiag


:runDiag
cls
echo Unpacking %diagActive% module....
echo.
echo.

if exist "%pclTempMain%" %rmdir% "%pclTempMain%"
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

%pclExtractModule% "%pclModulesPath%\diagnostics\%diagActive%.pcl" "%pclTempMain%"
call "%pclMenuPath%\diagnostics\fixes.cmd"
%runShellTerminateAndWait% "%runDirectory%\launch.cmd"

goto reset


:chkExit

:: Exit Status Key
:: back - Returns one menu back
:: close - Runs cleanup routine and exits window
:: return - Return to reset label at top of script

if %menuItem%==B set exitStatus=back
if %menuItem%==b set exitStatus=back

if %menuItem%==X set exitStatus=close
if %menuItem%==x set exitStatus=close

:: If an exitStatus is not set then set it to return as default
::if not defined exitStatus set exitStatus=return

::::if %exitStatus%==return goto reset

goto end


:end


