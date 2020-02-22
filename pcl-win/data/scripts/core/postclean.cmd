@echo off


set titleText=Cleaning Log Files and Other Junk :: portablecleaninglab.com
title %titleText%

%bannerMenuDefault%

echo Cleaning Up....
echo.

:: Pre-clean temp scanner auto files
%rm% "%pclTempUser%\detectme.scanner.*"

%rm% "%windir%\temp\pcl.set"

%bannerMenuDefault%

echo Cleaning Up....
echo.

:: Other log and misc files
%rm% %rootDrive%\deltmh_log.log
%rm% %rootDrive%\kavremvr*.log
%rm% %rootDrive%\detekt.log

:: Leftover file from x64dbg
%rm% %rootDrive%\snowman.ini
%rm% %rootDrive%\sc-cleaner.txt

%rm% %rootDrive%\wpeinit.log

if defined pclTempMain %rm% "%pclTempMain%\*"
if defined pclTempMain %rmsub% "%pclTempMain%"

if exist "%pclTempMain%\rootDrive.id" %rm% "%pclTempMain%\rootDrive.id"
if exist "%pclTempMain%\targetDrive.id" %rm% "%pclTempMain%\targetDrive.id"

if defined pd %rm% "%pd%\pcl\*"
if defined pd %rmsub% "%pd%\pcl"

%rm% "%windir%\temp\currentLocalUser.id"

::md "%pclTempMain%"
::md "%pclTempTemp%"


if %peModeState%==enabled (
%rm% "%targetDriveLetterDefaultPE%:\pcl"
%rmsub% "%targetDriveLetterDefaultPE%:\pcl"

%rm% "%targetDriveLetterDefaultPE%\ProgramData\pcl\*"
%rmsub% "%targetDriveLetterDefaultPE%\ProgramData\pcl"
)

if exist  "%targetDriveLetterDefaultPE%:\pcl" %rm% "%targetDriveLetterDefaultPE%:\pcl"
if exist "%targetDriveLetterDefaultPE%:\pcl" %rmsub% "%targetDriveLetterDefaultPE%:\pcl"

if exist "%targetDriveLetterDefaultPE%\ProgramData\pcl" %rm% "%targetDriveLetterDefaultPE%\ProgramData\pcl\*"
if exist "%targetDriveLetterDefaultPE%\ProgramData\pcl" %rmsub% "%targetDriveLetterDefaultPE%\ProgramData\pcl"


:: Kill lingering processes
%kill% "SVRTservice.exe"


%bannerMenuDefault%

echo Cleanup Finished!
echo.


:end

