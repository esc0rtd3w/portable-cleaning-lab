@echo off

:reset

%checkNetworkStatus%

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set titleText=Recovery Tools :: portablecleaninglab.com
%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
echo.
echo 1) EKey Finder (Windows Key Tool)
echo.
echo 2) NTPW Edit (NT Password Editor)
echo.
echo 3) Password Renew (NT Password Editor)
echo.
echo 4) Recuva (Recover Files From Media)
echo.
echo 5) Unstoppable Copier (Recover Files From Media)
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

if %menuItem% gtr 5 goto reset

if %menuItem%==1 set recoveryToolActive=ekey-finder
if %menuItem%==2 set recoveryToolActive=ntpwedit
if %menuItem%==3 set recoveryToolActive=password-renew
if %menuItem%==4 set recoveryToolActive=recuva
if %menuItem%==5 set recoveryToolActive=unstoppable-copier

set runDirectory=%pclTempMain%\%recoveryToolActive%

goto runRecovery


:runRecovery
cls
echo Unpacking %recoveryToolActive% module....
echo.
echo.

if exist "%pclTempMain%" %rmdir% "%pclTempMain%"
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

%pclExtractModule% "%pclModulesPath%\recovery\%recoveryToolActive%.pcl" "%pclTempMain%"
call "%pclMenuPath%\recovery\fixes.cmd"
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


