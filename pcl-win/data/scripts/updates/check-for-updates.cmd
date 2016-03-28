@echo off

title Portable Cleaning Lab - Check For Updates - pclupdate.com


color 0e

set getPCLVersionFileFromServer=%wgetWithAltSave% "%pclTempUpdates%\%pclConfigFileMainLocal%" "%updateServer%/%remoteUpdatePath%/%pclConfigFileMainRemote%"

:: If INI config has disabled updates then leave the script
if %disableUpdates%==1 (
%msgBox% "Updates have been disabled by the pcl.ini config file." "Updates Have Been Disabled!"
goto end
)

:: Recheck network status before checking for updates
%checkNetworkStatus%
if %networkStatus%==online goto check

cls
%cocolor% 0f
if defined bannerText echo %bannerText%
%cocolor% 0e
echo.
echo No Internet Connection Detected!
echo.
echo.
echo Please click OK on the message box to continue....
echo.

set msgBoxText="No Internet Connection Detected!"

%msgBox% %msgBoxText% %msgBoxTitle% %msgBoxStyleDefault%

goto end

:check
cls
%cocolor% 0f
if defined bannerText echo %bannerText%
%cocolor% 0e
echo.
echo Checking For Updates....
echo.
echo.

%createLocalTempDirectoryStructure%
%getPCLVersionFileFromServer%

:: Check for corrupt pcl.ini file before parsing (causes a force close) (added 20150609)
:: THIS SOMEHOW BREAKS?? UPDATES WHEN USED (20150704)
%iniVerifyMainConfig%

:: MD5 Check forced to bypass any issues with server being down (added 20150704)
:: Check for CORRUPT_DETECTION from pcl.ini header
if %configCorruptionDetectionValue%==1 goto end

:: If the hashes DO NOT match, then DO NOT continue, as this may result in an incorrect result
if %configHashesMatch%==0 goto end

%getLocalConfig%

if %pclRemoteVersion% gtr %pclLocalVersion% (

%buildUpdateList%

goto doUpdate

)

if %pclRemoteVersion%==%pclLocalVersion% goto noUpdate
if %pclRemoteVersion% lss %pclLocalVersion% goto devRel
if %pclRemoteVersion%==0.0.0 goto fail

:: Default to fail if above criteria does not match
:: Will add a check for a lower version on server to jump to unreleased message
goto fail
::goto end


:doUpdate

%parseUpdateFiles%

goto end


:noUpdate

:: Skip msgbox if there are no updates (add to pcl.ini later 20150521)
:: Only jump to end if initUpdate is TRUE (added 20150525)
if %initUpdate%==1 goto end

cls
%cocolor% 0f
if defined bannerText echo %bannerText%
%cocolor% 0e
echo.
echo There are currently no updates!
echo.
echo.
echo Please click OK on the message box to continue....
echo.

:: Change to msgbox style (added 20150521)
set msgBoxText="There are currently no updates!\n\nLocal Version: %pclLocalVersion%\n\nRemote Version: %pclRemoteVersion%"

%msgBox% %msgBoxText% %msgBoxTitle% %msgBoxStyleDefault%

goto end


:devRel

cls
%cocolor% 0f
if defined bannerText echo %bannerText%
%cocolor% 0e
echo.
echo You have a developer or pre-release version!
echo.
echo.
echo Please click OK on the message box to continue....
echo.

:: Change to msgbox style (added 20150521)
set msgBoxText="You have a developer or pre-release version!\n\nLocal Version: %pclLocalVersion%\n\nRemote Version: %pclRemoteVersion%"

%msgBox% %msgBoxText% %msgBoxTitle% %msgBoxStyleDefault%

goto end


:turd
setlocal ENABLEDELAYEDEXPANSION


set processList=0
for /f "tokens=*" %%a in (%list%) do (
    set /a processList=!processList! + 1
	::%kill% "%%a"
)


endlocal


if %updateSucceed%==0 goto fail
if %updateSucceed%==1 echo 1>"%pclTempMain%\updateCheck.reboot"

goto end


:fail

cls
%cocolor% 0f
if defined bannerText echo %bannerText%
%cocolor% 0c
echo.
echo Updates failed!
echo.
echo.
echo The PCL could not retrieve the version number from server!
echo.
echo.
echo Please click OK on the message box to continue....
echo.

:: Change to msgbox style (added 20150521)
set msgBoxText="Updates failed!\n\nThe PCL could not retrieve the version number from server!\n\n\nLocal Version: %pclLocalVersion%\n\nRemote Version: %pclRemoteVersion%"

%msgBox% %msgBoxText% %msgBoxTitle% %msgBoxStyleDefault%

echo 1>"%pclTempMain%\updateCheck.fail"

goto end



:end

:: Reset initUpdate after launch (added 20150525)
if %initUpdate%==1 set initUpdate=0

::pause
::%showText% %updateList%
::%showText% %updateListMD5%


