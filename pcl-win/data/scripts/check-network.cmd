@echo off

::color 0b

if not exist "%temp%\pcl" md "%temp%\pcl"


:: Checking network connectivity

setlocal ENABLEDELAYEDEXPANSION

ver | find "5.1"
if %errorlevel%==0 set ostype=xp

ver | find "6.0"
if %errorlevel%==0 set ostype=vista

ver | find "6.1"
if %errorlevel%==0 set ostype=win7

ver | find "6.2"
if %errorlevel%==0 set ostype=win8

ver | find "6.3"
if %errorlevel%==0 set ostype=win81

ver | find "6.4"
if %errorlevel%==0 set ostype=win10

cls
echo Checking Network Status....
echo.
echo.

set host=google.com

:: Set default online reply messages per OS
::set replyWinXP=TTL
set replyWinXP=Reply from
set replyWinVista=Reply from
set replyWin7=Reply from
set replyWin8=Reply from
set replyWin81=Reply from
set replyWin10=Reply from


if %ostype%==xp (
ping -n 1 %host% | find "%replyWinXP%">nul
if not errorlevel 1 set lanStatus=online
if errorlevel 1 set lanStatus=offline
)

if %ostype%==vista (
ping -n 1 %host% | find "%replyWinVista%">nul
if not errorlevel 1 set lanStatus=online
if errorlevel 1 set lanStatus=offline
)

if %ostype%==win7 (
ping -n 1 %host% | find "%replyWin7%">nul
if not errorlevel 1 set lanStatus=online
if errorlevel 1 set lanStatus=offline
)

if %ostype%==win8 (
ping -n 1 %host% | find "%replyWin8%">nul
if not errorlevel 1 set lanStatus=online
if errorlevel 1 set lanStatus=offline
)

if %ostype%==win81 (
ping -n 1 %host% | find "%replyWin81%">nul
if not errorlevel 1 set lanStatus=online
if errorlevel 1 set lanStatus=offline
)
	
if %ostype%==win10 (
ping -n 1 %host% | find "%replyWin10%">nul
if not errorlevel 1 set lanStatus=online
if errorlevel 1 set lanStatus=offline
)

if !lanStatus!==online (
set lanStatus=online
del /f /q "%pclTempMain%\lanstatus.offline"
echo online>"%pclTempMain%\lanstatus.online"
)
	
if !lanStatus!==offline (
set lanStatus=offline
del /f /q "%pclTempMain%\lanstatus.online"
echo offline>"%pclTempMain%\lanstatus.offline"
)
	
endlocal

:: Set variables for main PCL while we are in here (added 20141126)
if exist "%pclTempMain%\lanstatus.online" set networkStatus=online
if exist "%pclTempMain%\lanstatus.offline" set networkStatus=offline


:end

::exit

