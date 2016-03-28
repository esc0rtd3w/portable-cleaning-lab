@echo off


:reset

%checkNetworkStatus%

:: Recheck next available drive letter (added 20141201)
:: Solves issues when devices are connected after initial launch
%getNextAvailableDriveLetter%
%setNextAvailableDriveLetter%

:: Avast Temp Fix Part 2 - Added 20140727
if exist "%pclTempTemp%\avast\menu.fix" set avastFix=1

if %avastFix%==1 %rm% "%pclTempTemp%\avast\menu.fix"
if %avastFix%==1 goto chkExit

::set doubleLaunchFix=0

set tag=doPick
set fixtype=pick
set scanType=2

set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2

set runDirectory=%pclTempMain%\%moduleActive%

:: Fix for scanner variable misbehaving (20141102)
set scanner=999

set titleText=Scanning Options :: portablecleaninglab.com
%bannerMenuDefault%

:: Refresh current environment if not SYSTEM
::if not exist "%windir%\temp\systemInit.cmd" set>%pclCurrentEnvironment%

set moduleDefinitionsStatus=internal
set moduleScannerStatus=mbam.exe
set moduleServicesStatus=0
set moduleRegistryStatus=0

%cocolor% 0b
echo Active Module: %moduleActive%   Type: %moduleType%   Sub-Type: %moduleSubType%
echo.
::echo Definitions: %moduleDefinitionsStatus%   Scanner: %moduleScannerStatus%
::echo.
::echo Services: %moduleServicesStatus%   Registry: %moduleRegistryStatus%
::echo.
echo Run Path: %runDirectory%
echo.
echo.
%cocolor% 0a
echo TIP: SIMPLY PRESSING ENTER WILL START A DEFAULT SCAN ONLY
echo.
echo.
%cocolor% 0e
echo Select an option from below and press ENTER:
echo.
echo.
echo 1) Update and Scan
echo.
echo 2) Scan Only
echo.
echo 3) Update Module
echo.
echo 4) Download Module
echo.
echo.
echo B) Go Back
echo.
echo X) Exit This Window
echo.

set /p scanType=

:: Injection of files into active module 20140809
if %injectStatus%==ON %injectIntoActiveModule%

if %scanType%==B goto chkExit
if %scanType%==b goto chkExit

if %scanType%==X goto chkExit
if %scanType%==x goto chkExit

if %scanType% gtr 4 goto reset

if %scanType%==1 goto doScanUpdate
if %scanType%==2 goto doScan
if %scanType%==3 goto doUpdateRepack
if %scanType%==4 goto doDLCopy

goto chkExit


:doScanUpdate

set tag=doScanUpdate
set fixtype=scanupdate

%bannerMenuDefault%
%unpackActiveModule%
%updateActiveModule%

%bannerMenuDefault%
%runActiveModule%

goto chkExit


:doUpdateRepack

set tag=doUpdateRepack
set fixtype=repack

%bannerMenuDefault%
%unpackActiveModule%
%updateActiveModule%

%bannerMenuDefault%

if %updateFailed%==0 %repackActiveModule%

goto chkExit


:doScan

set tag=doScan
set fixtype=scan

%bannerMenuDefault%
%unpackActiveModule%
%runActiveModule%

goto chkExit


:doDLCopy

set tag=doDLCopy
set fixtype=dlcopy

%bannerMenuDefault%
%downloadActiveModule%

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

