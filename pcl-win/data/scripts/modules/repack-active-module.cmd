@echo off


::set tempDirectory=%pclTempUser%
set runDirectory=%pclTempMain%\%moduleActive%
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

:: Remove run folder if present
if exist "%runDirectory%\run" %rmdir% "%runDirectory%\run"


:: Testing to make sure variables are correct (debug purposes only)
::echo pclModulesPath: %pclModulesPath%
::echo moduleType: %moduleType%
::echo moduleSubType: %moduleSubType%
::echo moduleActive: %moduleActive%
::echo moduleSubTypeLayers: %moduleSubTypeLayers%
::pause


:: Start Busy Popup for repack
%busyPopupDefault%

:: Create virtual drive for temp PCL module - added 20141010
%rmdir% "%pclModuleTempPath%"
%mkdir% "%pclModuleTempPath%"

:: Recheck next available drive letter (added 20141201)
:: Solves issues when devices are connected after initial launch
%getNextAvailableDriveLetter%
%setNextAvailableDriveLetter%
%virtualTempDriveCreate%

:: Make default directory for virtual drive path
%bannerMenuDefault%
echo.
echo %msgRepack%
echo.
echo.
%mkdir% "%virtualDriveLetter%\%moduleActive%">nul

:: Copy Module From Main Temp To Virtual Path
%bannerMenuDefault%
echo.
echo %msgRepack%
echo.
echo.
%cp% "%pclTempMain%\%moduleActive%" "%virtualDriveLetter%\%moduleActive%">nul

:: Compress New PCL Module From Contents of Virtual Path
%bannerMenuDefault%
echo.
echo %msgRepack%
echo.
echo.
%pclCompress% "%virtualDriveLetter%\%moduleActive%.pcl" "%virtualDriveLetter%\%moduleActive%">nul

:: Copy Newly Compressed Module From Virtual Drive Path To Main Temp
%bannerMenuDefault%
echo.
echo %msgRepack%
echo.
echo.
%cp2% "%virtualDriveLetter%\%moduleActive%.pcl" "%pclTempMain%">nul


:: Check Path Layout
:: Set Copy Module Message
:: Copy Module From Virtual Drive Path To Source Media
%bannerMenuDefault%

:: If the path layout is one layer deep
if %moduleSubTypeLayers%==1 (
echo.
echo Copying to %pclModulesPath%\%moduleType%\%moduleActive%.pcl....
echo.
echo.
%cp2% "%virtualDriveLetter%\%moduleActive%.pcl" "%pclModulesPath%\%moduleType%">nul
)


:: If the path layout is two layers deep
if %moduleSubTypeLayers%==2 (
echo.
echo Copying to %pclModulesPath%\%moduleType%\%moduleSubType%\%moduleActive%.pcl....
echo.
echo.
%cp2% "%virtualDriveLetter%\%moduleActive%.pcl" "%pclModulesPath%\%moduleType%\%moduleSubType%">nul
)

:: If the path layout is three layers deep
if %moduleSubTypeLayers%==3 (
echo.
echo Copying to %pclModulesPath%\%moduleType%\%moduleSubType%\%moduleSubType3%\%moduleActive%.pcl....
echo.
echo.
%cp2% "%virtualDriveLetter%\%moduleActive%.pcl" "%pclModulesPath%\%moduleType%\%moduleSubType%\%moduleSubType3%">nul
)


:: Remove Module From Main Temp
%bannerMenuDefault%
echo.
echo %msgRemoveTemp%
echo.
echo.
%rm% "%pclTempMain%\%moduleActive%.pcl">nul

:: Remove Module From Virtual Drive Path
%bannerMenuDefault%
echo.
echo %msgRemoveTemp%
echo.
echo.
%rm% "%virtualDriveLetter%\%moduleActive%.pcl">nul

:: Remove Entire Virtual Path
%bannerMenuDefault%
echo.
echo %msgRemoveTemp%
echo.
echo.
%rmdir% "%virtualDriveLetter%\%moduleActive%">nul

:: Destroy Virtual Drive
%bannerMenuDefault%
echo.
echo %msgRemoveTemp%
echo.
echo.
%wait% 1
%virtualTempDriveDestroy%
%wait% 1

:: Remove Uncompressed Files From Module Temp Path
%rmdir% "%pclModuleTempPath%\%moduleActive%">nul
%rmdir% "%pclModuleTempPath%"
%mkdir% "%pclModuleTempPath%"


:: Close Busy Popup
%busyPopupClose%


:end

