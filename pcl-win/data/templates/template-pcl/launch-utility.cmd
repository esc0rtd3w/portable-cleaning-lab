@echo off

::----------------------------------------------------------------------------------
:: PORTABLE CLEANING LAB MODULE FRAMEWORK TEMPLATE (LAUNCH UTILITY)

:: THIS CONTAINS CUSTOM SCRIPTING TO ASSIST IN CREATING A TRULY PORTABLE APP.

:: IT SUPPORTS MANY FUNCTIONS FOR ARCHIVING, EXTRACTING, COPYING, UPDATING, AND MORE.

:: TO USE THIS TEMPLATE, UNCOMMENT THE LINES THAT YOU NEED FOR CERTAIN EVENTS.
:: EVERY KEY PART OF THE APPLICATION MUST BE STORED IN THE APPROPRIATE BLOB FILE.
:: MOST ITEMS ARE GROUPED IN THEIR NATURAL ORDER OF EXECUTION TO EASILY FOLLOW.

:: THIS TEMPLATE MAY BE FREELY USED AND/OR MODIFIED TO SUIT YOUR NEEDS.
:: PLEASE LEAVE CREDITS IN COMMENTS IF REDISTRIBUTING THIS CODE.

:: esc0rtd3w / 2015 PCL Team                      http://www.portablecleaninglab.com
::----------------------------------------------------------------------------------

:: Main RESET Point HERE
:reset

:: Default Color
color 0e

set appName=PCL Module
set appBin=app.exe
set appVersion=0.0.0.0

set scriptVersion=v3.0


title %appName% Portable Launcher %scriptVersion% :: portablecleaninglab.com


:: Checking if running from PCL menu or standalone launch
if "%pclActive%"=="" set runDirectory=%cd%

:: Check parent directory name (also sets module name)
set moduleNameTemp=%~p0
set moduleNameTemp=%moduleNameTemp:~1,-1%
set moduleNameTemp=%moduleNameTemp:\=,%
set moduleNameTemp=%moduleNameTemp: =_%
for %%a in (%moduleNameTemp%) do set "moduleName=%%a"
set moduleName=%moduleName:_= %


:: Set dependency file variables
set pack7z="%runDirectory%\data\7z.exe" a -y -r
set packRar="%runDirectory%\data\rar.exe" a -m5
set packZip="%runDirectory%\data\zip.exe"
set unpack7z="%runDirectory%\data\7z.exe" -y x
set unpackRar="%runDirectory%\data\rar.exe" x
set unpackZip="%runDirectory%\data\unzip.exe"


set sevenZ="%runDirectory%\data\7z.exe"
set cocolor="%runDirectory%\data\cocolor.exe"
set inifile="%runDirectory%\data\inifile.exe"
set instsrv="%runDirectory%\data\instsrv.exe"
set md5sum="%runDirectory%\data\md5sums.exe" -b -e
set msgbox="%runDirectory%\data\msgbox.exe"
set nircmd="%runDirectory%\data\nircmd.exe"
set nircmd64="%runDirectory%\data\nircmd64.exe"
set nop="%runDirectory%\data\nop.exe"
set rar="%runDirectory%\data\rar.exe"
set srvany="%runDirectory%\data\srvany.exe"
set taskkill="%runDirectory%\data\taskkill.exe"
set tasklist="%runDirectory%\data\tasklist.exe"
set unzip="%runDirectory%\data\unzip.exe"
set wait="%runDirectory%\data\wait.exe"
set wget="%runDirectory%\data\wget.exe"
set xml="%runDirectory%\data\xml.exe"
set zip="%runDirectory%\data\zip.exe"

set rm=del /f /q
set rmdir=rd /q
set rmdir2=rd /s /q
set cp=copy /y

set kill=taskkill /f /im


set extractedDir=%systemDrive%\PCLTEMP
set pclTempDir=%temp%\pcl\temp


:: Set update date and time
set updateTimeDate=%date% %time%


:: Setting up registry settings
set regAdd=regedit /s "%cd%\data\_default_add.reg"
set regRemove=regedit /s "%cd%\data\_default_remove.reg"
set regRun=regedit /s "%cd%\data\_default_run.reg"

set svcAdd=regedit /s "%cd%\data\_svc_add.reg"
set svcAdd2=regedit /s "%cd%\data\_svc_add_srvany.reg"
set svcRemove=regedit /s "%cd%\data\_svc_remove.reg"


:: Common Paths
::set pf=%systemdrive%\Program Files
set pf=%ProgramFiles%
set cf=%systemdrive%\Program Files\Common Files
::set pf64=%systemdrive%\Program Files (x86)
set pf64=%ProgramFiles(x86)%
set cf64=%systemdrive%\Program Files (x86)\Common Files
set pd=%ProgramData%
set pdxp=C:\Documents and Settings\%username%\Application Data
set adl=%LocalAppData%
set adlxp=%USERPROFILE%\Local Settings\Application Data\Local
set adll=%SystemDrive%%HomePath%\AppData\LocalLow
set adllxp=%USERPROFILE%\Local Settings\Application Data\LocalLow
set adr=%AppData%
set adrxp=%USERPROFILE%\Local Settings\Application Data\Roaming
set au=%ALLUSERSPROFILE%
set auxp=C:\Documents and Settings\All Users
set cu=%UserProfile%
set win=%systemdrive%\Windows
set sys32=%systemdrive%\Windows\system32


:: Killing any active processes
%kill% "%appBin%"

:: Apply registry settings if needed
%regRun%
::%svcAdd%
::%svcAdd2%


:: Create a service
::sc create "%serviceName%" binpath= "%runDirectory%\data\%appBin%" start= demand DisplayName= "%serviceDisplayName%" error= ignore

:: Create a service (alternate)
::instsrv.exe "%serviceName%" "%runDirectory%\data\srvany.exe"

:: Start a service
::sc start "%serviceName%" binpath= "%runDirectory%\data\%appBin%"

:: Stop a service
::net stop %serviceName%

:: Delete a service
::sc delete "%serviceName%"


:: Launching App
cls
echo DO NOT CLOSE THIS WINDOW!!
echo.
echo.
::echo Last Update: %updateTimeDate%
echo.
echo.
echo Launching %appName% Portable [%version%]...
echo.
echo.

echo THIS IS A TEMPLATE ONLY! PLEASE EDIT THIS FILE TO SUIT YOUR NEEDS!
pause>nul
exit


cls
echo Running %appName%....

for %%a in (%~dp0*.exe) do set appCurrent=%%a

start "%appCurrent%"


:end

