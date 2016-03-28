@echo off


::set tempDirectory=%pclTempUser%
set runDirectory=%pclTempMain%\%moduleActive%
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

:start

echo.
echo Downloading....
echo.
echo.

if exist "%pclTempMain%" %rmdir% "%pclTempMain%"
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

%wgetWithAltSave% "%pclTempMain%\%moduleActive%.pcl" "%updateServer%/%remoteUpdatePath%/%remoteUpdatePathModulesCleaningScanners%/%moduleActive%.pcl"

set targetFile=%pclTempMain%\%moduleActive%.pcl

for %%a in ("%targetFile%") do (
  if %%~za equ 0 (
	set zeroByteFile=1
  ) else (
	set zeroByteFile=0
  )
)

if %zeroByteFile%==1 (
%rm% "%targetFile%"
goto fail
)

goto copy


:fail
set updateFailedRetry=99
%bannerMenuDefault%

echo The PCL could not retrieve the module from server!
echo.
echo.
echo Press ENTER to try again or B and ENTER to go back....
echo.
echo.

set /p updateFailedRetry=

if %updateFailedRetry%==B goto end
if %updateFailedRetry%==b goto end

goto start


:copy

%bannerMenuDefault%

echo.
echo Download Complete!
echo.
echo.

:: Start Busy Popup for repack
%busyPopupDefault%

%bannerMenuDefault%

echo.
echo %msgCopyModule%
echo.
echo.

:: If the path layout is one layer deep
if %moduleSubTypeLayers%==1 (
%cp2% "%pclTempMain%\%moduleActive%.pcl" "%pclModulesPath%\%moduleType%">nul
)

:: If the path layout is two layers deep
if %moduleSubTypeLayers%==2 (
%cp2% "%pclTempMain%\%moduleActive%.pcl" "%pclModulesPath%\%moduleType%\%moduleSubType%">nul
)

:: If the path layout is three layers deep
if %moduleSubTypeLayers%==3 (
%cp2% "%pclTempMain%\%moduleActive%.pcl" "%pclModulesPath%\%moduleType%\%moduleSubType%\%moduleSubType3%">nul
)


%bannerMenuDefault%

echo.
echo %msgRemoveTemp%
echo.
echo.
%rm% "%pclTempMain%\%moduleActive%.pcl">nul

:: Close Busy Popup
%busyPopupClose%


:end

