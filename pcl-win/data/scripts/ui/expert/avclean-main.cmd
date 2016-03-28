@echo off


:reset

%checkNetworkStatus%

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set titleText=Antivirus Cleaning and Removal Tools :: portablecleaninglab.com
%bannerMenuDefault%

echo Select an Antivirus to REMOVE and press ENTER:
echo.
echo.
echo 1) Avira Antivir
echo 2) Avast!
echo 3) AVG (32-bit)
echo 4) AVG (64-bit)
echo 5) Comodo
echo 6) ESET
echo 7) F-Secure
echo 8) HouseCall
echo 9) IOBit
echo 10) Kaspersky
echo 11) Norton
echo 12) OneCare
echo 13) Panda
echo 14) Security Essentials
echo 15) Trend Micro (32-bit)
echo 16) Trend Micro (64-bit)
echo 17) Vipre
echo 18) Webroot
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

if %menuItem% gtr 18 goto reset

if %menuItem%==1 set avcleanActive=avira
if %menuItem%==2 set avcleanActive=avast
if %menuItem%==3 set avcleanActive=avg-x86
if %menuItem%==4 set avcleanActive=avg-x64
if %menuItem%==5 set avcleanActive=comodo
if %menuItem%==6 set avcleanActive=eset
if %menuItem%==7 set avcleanActive=fsecure
if %menuItem%==8 set avcleanActive=housecall
if %menuItem%==9 set avcleanActive=iobit
if %menuItem%==10 set avcleanActive=kaspersky
if %menuItem%==11 set avcleanActive=norton
if %menuItem%==12 set avcleanActive=onecare
if %menuItem%==13 set avcleanActive=panda
if %menuItem%==14 set avcleanActive=security-essentials
if %menuItem%==15 set avcleanActive=trend-micro-x86
if %menuItem%==16 set avcleanActive=trend-micro-x64
if %menuItem%==17 set avcleanActive=vipre
if %menuItem%==18 set avcleanActive=webroot

set runDirectory=%pclTempMain%\%avcleanActive%

goto runAVClean


:runAVClean
cls
echo Unpacking %avcleanActive% module....
echo.
echo.

if exist "%pclTempMain%" %rmdir% "%pclTempMain%"
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

%pclExtractModule% "%pclModulesPath%\avclean\%avcleanActive%.pcl" "%pclTempMain%"
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


