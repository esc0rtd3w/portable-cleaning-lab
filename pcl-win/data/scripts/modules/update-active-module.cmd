@echo off

:reset

%checkNetworkStatus%

echo.
echo Updating....
echo.
echo.

::set tempDirectory=%pclTempUser%
set runDirectory=%pclTempMain%\%moduleActive%
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"


if exist "%pclTempMain%\lanstatus.online" (

:: If the path layout is one layer deep
if %moduleSubTypeLayers%==1 (
call "%pclMenuPath%\%moduleType%\fixes.cmd"
)

:: If the path layout is two layers deep
if %moduleSubTypeLayers%==2 (
call "%pclMenuPath%\%moduleType%\%moduleSubType%\fixes.cmd"
)

:: If the path layout is three layers deep
if %moduleSubTypeLayers%==3 (
call "%pclMenuPath%\%moduleType%\%moduleSubType%\%moduleSubType3%\fixes.cmd"
)

if %doubleLaunchFix%==0 call "%runDirectory%\update.cmd"

)

if exist "%pclTempMain%\lanstatus.offline" (
goto fail
)

goto end


:fail
%checkNetworkStatus%

%bannerMenuDefault%
echo.
%cocolor% 0c
echo Cannot Update While Network Is OFFLINE!!
%cocolor% 0e
echo.
echo.
%cocolor% 0b
echo Failed Attempts: %updateAttempts%
echo.
echo Remaining Attempts: %updateAttemptsRemaining%
%cocolor% 0e
echo.
echo.
echo Please connect to the internet!
echo.
echo Retrying in 5 seconds....
echo.
echo.

if %updateAttempts% lss %updateFailLimit% (
%wait% 5
set /a updateAttempts=%updateAttempts%+1
set /a updateAttemptsRemaining=%updateAttemptsRemaining%-1
)

if %updateAttempts%==%updateFailLimit% (
goto failMore
)

if %updateAttempts% gtr %updateFailLimit% (
goto failMore
)

goto reset


:failMore
set failResponse=1

:: Set Fail Defaults Before Returning To Loop
set updateFailed=1
set updateAttempts=0
set updateAttemptsRemaining=5
set updateFailLimit=5
%bannerMenuDefault%
echo.
echo You seem to still not be connected to the internet!
echo.
echo Would you like to retry or continue without updates?
echo.
echo.
echo 1) Retry
echo.
echo 2) Continue
echo.
echo.

set /p failResponse=

if "%failResponse%"=="" goto failMore
if %failResponse% gtr 2 goto failMore
if %failResponse%==1 goto reset
if %failResponse%==2 goto end


goto end



:end

