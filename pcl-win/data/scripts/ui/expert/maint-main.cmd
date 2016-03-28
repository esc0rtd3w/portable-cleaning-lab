@echo off

:reset

%checkNetworkStatus%

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set titleText=Maintenance Tools :: portablecleaninglab.com
%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
echo.
echo 1) ADW Cleaner
echo 2) Autoruns
echo 3) BHO Scanner
echo 4) CCleaner
echo 5) Cleanup!
echo 6) Clean After Me
echo 7) CryptoPrevent
echo 8) Defraggler
echo 9) Easy BCD (Windows Boot Manager)
echo 10) Free Uninstaller
echo 11) GWX Control Panel (Win10 Nag Suppression)
echo 12) Hijack Free
echo 13) HijackThis!
echo 14) Spybot: Anti-Beacon (Block Telemetry Data)
echo 15) TrashReg
echo 16) Unhide (Auto Unhide All Files)
echo 17) WinContig (Defragmenter)
echo 18) Windows Registry Recovery
echo 19) Windows Worms Doors Cleaner
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

if %menuItem% gtr 19 goto reset

if %menuItem%==1 set maintActive=adwcleaner
if %menuItem%==2 set maintActive=autoruns
if %menuItem%==3 set maintActive=bho-scanner
if %menuItem%==4 set maintActive=ccleaner
if %menuItem%==5 set maintActive=cleanup
if %menuItem%==6 set maintActive=clean-after-me
if %menuItem%==7 set maintActive=crypto-prevent
if %menuItem%==8 set maintActive=defraggler
if %menuItem%==9 set maintActive=easy-bcd
if %menuItem%==10 set maintActive=fun
if %menuItem%==11 set maintActive=gwx-control-panel
if %menuItem%==12 set maintActive=hijack-free
if %menuItem%==13 set maintActive=hijack-this
if %menuItem%==14 set maintActive=spybot-ab
if %menuItem%==15 set maintActive=trashreg
if %menuItem%==16 set maintActive=unhide
if %menuItem%==17 set maintActive=wincontig
if %menuItem%==18 set maintActive=windows-registry-repair
if %menuItem%==19 set maintActive=wwdc

set runDirectory=%pclTempMain%\%maintActive%

goto runMaint


:runMaint

cls
echo Unpacking %maintActive% module....
echo.
echo.

if exist "%pclTempMain%" %rmdir% "%pclTempMain%"
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

%pclExtractModule% "%pclModulesPath%\maintenance\%maintActive%.pcl" "%pclTempMain%"
call "%pclMenuPath%\maintMainenance\fixes.cmd"
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


