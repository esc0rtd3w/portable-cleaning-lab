@echo off

:reset

set nameTitle=Clone PCL To Another Destination :: portablecleaninglab.com

set usbSource=%~dp0

::set sizeSource=dir /s
::set sizeFreeSpace=dir /s | find "bytes free"

for /f "tokens=*" %%a IN ('"dir /s /-c | find "bytes" | find /v "free""') do @set sizeFreeSpace=%%a
for /f "tokens=1,2 delims=)" %%a in ("%sizeFreeSpace%") do set sizeSource=%%b

set usbDestination=%systemdrive%

title %nameTitle%
%bannerMenuDefault%

echo.
echo Enter Destination To Clone PCL To and Press ENTER:
echo.
echo.
echo Example: F:
echo.
echo.
echo DO NOT INCLUDE THE TRAILING SLASH "\"
echo.
echo.
echo Current Source Size: %sizeSource%
echo.
echo Current Destination: %usbDestination%
echo.
echo.
echo Press B and ENTER to return to main menu
echo.
echo.

set /p usbDestination=


if [%usbDestination%]==[b] goto chkExit
if [%usbDestination%]==[B] goto chkExit
if [%usbDestination%]==[] goto reset

goto resetp


:cloneusbp

%bannerMenuDefault%

echo.
echo Source: %usbSource% 
echo.
echo Target: %usbDestination%\%pclReleaseBaseName%\
echo.
echo.
echo Press ENTER to continue or "B" and ENTER to go back....
echo.
echo.

set /p cloneusbpDest=

if [%cloneusbpDest%]==[b] goto reset
if [%cloneusbpDest%]==[B] goto reset
if [%cloneusbpDest%]==[] goto resetc

goto reset


:cloneusbc
%bannerMenuDefault%

echo.
echo This is going to take a while....Hang Tight!
echo.
echo.
echo DO NOT CLOSE THIS WINDOW OR THE CLONING PROCESS WILL FAIL!!!!
echo.
echo.

%busyPopupDefault%

%mkdir% "%usbDestination%\%pclReleaseBaseName%"
xcopy "%usbSource%*" "%usbDestination%\%pclReleaseBaseName%" /s /e /y /f

%busyPopupClose%

echo.
echo.
echo.
echo.
echo Finished!
echo.
echo.
echo Check for any errors and press any key to exit....
echo.
echo.

pause>nul

goto chkExit


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

