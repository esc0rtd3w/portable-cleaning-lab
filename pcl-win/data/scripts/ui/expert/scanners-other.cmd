@echo off

:reset

%checkNetworkStatus%

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set titleText=Rootkit and Other Scanners :: portablecleaninglab.com
%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
echo.
echo 1) Antivir Removal Tool
echo 2) Detekt
echo 3) File Assassin
echo 4) GMER
echo 5) GooredFix
echo 6) Hitman Pro
echo 7) Junkware Removal Tool
echo 8) Lenovo Superfish Removal Tool
echo 9) Malwarebytes Anti-Exploit*
echo 10) Malwarebytes Anti-Rootkit*
echo 11) Norton Power Eraser
echo 12) Reg Assassin
echo 13) Rootkit Revealer
echo 14) TDSSKiller
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

if %menuItem% gtr 14 goto reset

if %menuItem%==1 set scannerSaActive=avira
if %menuItem%==2 set scannerSaActive=detekt
if %menuItem%==3 set scannerSaActive=file-assassin
if %menuItem%==4 set scannerSaActive=gmer
if %menuItem%==5 set scannerSaActive=gooredfix
if %menuItem%==6 set scannerSaActive=hitman-pro
if %menuItem%==7 set scannerSaActive=jwrt
if %menuItem%==8 set scannerSaActive=superfish-removal
if %menuItem%==9 set scannerSaActive=mbae
if %menuItem%==10 set scannerSaActive=mbar
if %menuItem%==11 set scannerSaActive=norton-power-eraser
if %menuItem%==12 set scannerSaActive=reg-assassin
if %menuItem%==13 set scannerSaActive=rootkit-revealer
if %menuItem%==14 set scannerSaActive=tdsskiller

set runDirectory=%pclTempMain%\%scannerSaActive%

::goto doPick
goto runSA




:runSA
cls
echo Unpacking %scannerSaActive% module....
echo.
echo.

if exist "%pclTempMain%" %rmdir% "%pclTempMain%"
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

%pclExtractModule% "%pclModulesPath%\cleaning\tools\%scannerSaActive%.pcl" "%pclTempMain%"
::call "%pclMenuPath%\utilities\fixes.cmd"
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


