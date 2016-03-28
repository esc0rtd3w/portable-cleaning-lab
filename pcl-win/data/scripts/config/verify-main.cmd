@echo off

:: Hash Output Fixed 20150704

::----------------------------------------------------------------------------
:: REMOTE CONFIG

%md5% "%pclTempUpdates%\%pclConfigFileMainRemote%" > %temp%\md5.tmp

:: Example output 
:: 8D443F2E93A3F0B67F442E4F1D5A4D6D  md5.exe

::notepad %temp%\md5.tmp

set /p md5temp= < %temp%\md5.tmp

set md5temp2=%md5temp:~0,32%

echo %md5temp2% > %temp%\md5.tmp

:: Example output 
:: 8D443F2E93A3F0B67F442E4F1D5A4D6D

set /p configHashRemote= < %temp%\md5.tmp

::notepad %temp%\md5.tmp
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: LOCAL CONFIG

%md5% "%pclRootPath%\%pclConfigFileMainLocal%" > %temp%\md5.tmp

:: Dump config to TEMP for corruption detection at the end
copy /y "%pclRootPath%\%pclConfigFileMainLocal%" "%temp%\pcl_config.tmp"

set /p md5temp= < %temp%\md5.tmp

set md5temp2=%md5temp:~0,32%

echo %md5temp2% > %temp%\md5.tmp

set /p configHashLocal= < %temp%\md5.tmp
::----------------------------------------------------------------------------


set configHashesMatch=0
if %configHashRemote%==%configHashLocal% set configHashesMatch=1

::cls
::echo Local Config: %configHashLocal%
::echo Remote Config: %configHashRemote%
::echo.

::if %configHashesMatch%==0 echo CONFIG IS OUTDATED!
::if %configHashesMatch%==1 echo CONFIG IS UP TO DATE!

::pause


:: Check for CORRUPTION_DETECTION in pcl.ini header (EXTRA PROTECTION)
:: VALID HEADER: 434f5252555054494f4e5f444554454354494f4e
set /p configCorruptionDetectionTemp= < %temp%\pcl_config.tmp
set configCorruptionDetectionValue=%configCorruptionDetectionTemp:~2,40%

set configCorruptionDetection=1
if %configCorruptionDetectionValue%==434f5252555054494f4e5f444554454354494f4e set configCorruptionDetection=0

::echo Value: %configCorruptionDetectionValue%
::echo Corrupt: %configCorruptionDetection%

::pause

