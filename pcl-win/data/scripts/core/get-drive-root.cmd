@echo off

if not exist "%temp%\pcl" md "%temp%\pcl"

::for /l %%a in (1,1,10) do (
::    pushd ..
::)

set rootDrive=%~dp0
::popd

:: Old Method Removed 20141208
::set current=%~dp0
::pushd ..
::pushd ..
::pushd ..
::pushd ..
::pushd ..
::set rootDrive=%cd%
::popd

setlocal enabledelayedexpansion

set rootDrive=!rootDrive:~0,-27!
set rootDriveLetter=!rootDrive:~0,-1!

:: Output local variables to text so they are saved past the session.
echo !rootDrive!>"%temp%\pcl\rootDrive.id"
echo !rootDriveLetter!>"%temp%\pcl\rootDriveLetter.id"

endlocal

:: Setting default root drive (E:)
::set /p rootDrive=<"%temp%\pcl\rootDrive.id"
set rootDrive=%~d0
echo %rootDrive%>"%temp%\pcl\rootDrive.id"

:: Setting default root drive letter only (E)
set /p rootDriveLetter=<"%temp%\pcl\rootDriveLetter.id"

:: %~0		Get Full Path of Current Running Batch
:: %~dp0	Get Path of Batch File Execution With Backslash \
:: %~s0		Get Full Path of Current Running Batch
:: %~p0		Get Parent Folder Including Surrounding Backslashes \pcl-win\
:: %~d0		Get Drive Letter and Colon Only
:: %~n0		Get Filename Only, No Extension and No Path
:: %~x0		Get File Extension Only
:: %~z0		Get Size In Bytes??
:: %~a0		Get Attributes of Current Running Batch
:: %~t0		Display Date and Time


::echo %rootDrive%
::echo %rootDriveLetter%

::pause



:end

