@echo off


echo.
echo Scanning....
echo.
echo.

::set tempDirectory=%pclTempUser%
set runDirectory=%pclTempMain%\%moduleActive%
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

:: If the path layout is one layer deep
if %moduleSubTypeLayers%==1 (
call "%pclMenuPath%\%moduleType%\fixes.cmd"
if %doubleLaunchFix%==0 %runShellTerminateAndWait% "%runDirectory%\launch.cmd"
)

:: If the path layout is two layers deep
if %moduleSubTypeLayers%==2 (
call "%pclMenuPath%\%moduleType%\%moduleSubType%\fixes.cmd"
if %doubleLaunchFix%==0 %runShellTerminateAndWait% "%runDirectory%\launch.cmd"
)

:: If the path layout is three layers deep
if %moduleSubTypeLayers%==3 (
call "%pclMenuPath%\%moduleType%\%moduleSubType%\%moduleSubType3%\fixes.cmd"
if %doubleLaunchFix%==0 %runShellTerminateAndWait% "%runDirectory%\launch.cmd"
)


:end

