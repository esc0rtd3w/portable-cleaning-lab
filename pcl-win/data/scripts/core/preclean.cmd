@echo off

cls
echo Cleaning Up....
echo.

:: Pre-clean temp scanner auto files
%rm% "%pclTempUser%\detectme.scanner.*"

:: Pre-clean pcl folder
if defined pclTempMain %rm% "%pclTempMain%\*"
if defined pclTempMain %rmdir% "%pclTempMain%"

:: Pre-clean remote version files
if exist %pclRemoteVersionFile% %rm% %pclRemoteVersionFile%

:: Pre-clean injection files
if exist "%pclTempMain%\lanstatus.online" %rm% "%pclTempMain%\lanstatus.online"
if exist "%pclTempMain%\lanstatus.offline" %rm% "%pclTempMain%\lanstatus.offline"

:: Pre-clean injection files
if exist "%pclTempMain%\inject.off" %rm% "%pclTempMain%\inject.off"
if exist "%pclTempMain%\inject.on" %rm% "%pclTempMain%\inject.on"

:: Pre-clean uiMode files
if exist "%pclTempMain%\uiMode.state" %rm% "%pclTempMain%\uiMode.state"

:: Pre-clean dump path files
if exist "%pclTempMain%\dump.path" %rm% "%pclTempMain%\dump.path"

:: Pre-clean update files
if exist "%pclTempMain%\updateCheck.fail" %rm% "%pclTempMain%\updateCheck.fail"

:: Pre-clean drive letter temp files
if exist "%pclTempMain%\rootDrive.id" %rm% "%pclTempMain%\rootDrive.id"
if exist "%pclTempMain%\targetDrive.id" %rm% "%pclTempMain%\targetDrive.id"

:: Pre-clean scanner update mode files
if exist "%pclTempMain%\scannerUpdateMode.multi" %rm% "%pclTempMain%\scannerUpdateMode.multi"
if exist "%pclTempMain%\scannerUpdateMode.default" %rm% "%pclTempMain%\scannerUpdateMode.default"

:: Other log and misc files
%rm% %rootDrive%\deltmh_log.log
%rm% %rootDrive%\kavremvr*.log
%rm% %rootDrive%\detekt.log

:: Leftover file from x64dbg
%rm% %rootDrive%\snowman.ini
%rm% %rootDrive%\sc-cleaner.txt

%rm% %rootDrive%\wpeinit.log

cls
echo Cleanup Finished!
echo.

:end

