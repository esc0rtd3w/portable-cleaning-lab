@echo off


:: Set current scanner module name as detectme file
set scannerDetectionFile="%tempDirectory%\detectme.scanner.%moduleActive%"
echo %moduleActive%>"%tempDirectory%\detectme.scanner.%moduleActive%"

%bannerMenuDefault%
echo Running %moduleActive%....
echo.
echo The next step will automatically be loaded!
echo.

::set tempDirectory=%pclTempUser%
set runDirectory=%pclTempMain%\%moduleActive%
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

if %supressModuleLaunch%==0 (
if exist "%pclTempMain%\lanstatus.online" call "%runDirectory%\update.cmd"
call "%runDirectory%\auto.cmd"
)

%rm% "%tempDirectory%\detectme.scanner.%moduleActive%"
%wait% 10


:end

