@echo off

::----------------------------------------------------------------------------------
:: PORTABLE CLEANING LAB MODULE FRAMEWORK TEMPLATE (LAUNCH MODE)

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

::----------------------------------------------------------------------------------
:: BEGIN SETTING VARIABLES
::----------------------------------------------------------------------------------

set scriptVersion=v3.2

::----------------------------------------------------------------------------------
:: THESE ARE THE ONLY VARIABLES NEEDED FOR GLOBAL COMPATIBILITY
set appName=APPNAMEHERE
set appBin=app.exe
set appVersion=0.0.0.0
:: Next Line Only Needed If All Users Folder Is Used
::set pathUpdatesLocalNameAU=APPFOLDERNAMEHERE
:: Next Line Only Needed If Current User Folder Is Used
::set pathUpdatesLocalNameCU=APPFOLDERNAMEHERE
:: Next Line Only Needed If AppData Local Folder Is Used
::set pathUpdatesLocalNameADL=APPFOLDERNAMEHERE
:: Next Line Only Needed If AppData LocalLow Folder Is Used
::set pathUpdatesLocalNameADLL=APPFOLDERNAMEHERE
:: Next Line Only Needed If PF Common Files Folder Is Used
::set pathUpdatesLocalNameCF=APPFOLDERNAMEHERE
:: Next Line Only Needed If Temp AU Folder Is Used
::set pathUpdatesLocalNameTempAU=APPFOLDERNAMEHERE
:: Next Line Only Needed If Temp CU Folder Is Used
::set pathUpdatesLocalNameTempCU=APPFOLDERNAMEHERE
:: Next Line Only Needed If Checking For Users Folder
::set pathUpdatesLocalNameUsers=APPFOLDERNAMEHERE
:: Next Line Only Needed If Checking For Root Folders (C:\)
::set pathUpdatesLocalNameRoot=APPFOLDERNAMEHERE
:: Next Line Only Needed If Checking For Local Installation
::set pathUpdatesLocalNamePF=APPFOLDERNAMEHERE
:: Next Line Only Needed For MSI Extraction
::set msiExtractPathTemp=Program Files\APPFOLDERNAMEHERE

:: Default Update Settings for use with WGET
::set remoteFile=http://www.website.com/file.zip
::set localFile=file.zip
::set remoteFile64=http://www.website.com/file64.zip
::set localFile64=file64.zip

:: Default Scanner/Definition Links for use with WGET
::set remoteFileScanner=http://www.website.com/scanner.zip
::set localFileScanner=scanner.zip
::set remoteFileDefinitions=http://www.website.com/definitions.zip
::set localFileDefinitions=definitions.zip

:: Change value to 1 ONLY if there are 2 separate x86 and x64 layouts required
set bitSplit=0
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: Get CPU Architecture
set bits=x86

if not exist "C:\Program Files (x86)" set bits=x86
if exist "C:\Program Files (x86)" set bits=x64
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set bits=x64
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: Check if user wants to use 32-bit version if 64-bit version is also available
if %bitSplit%==1 (

	if %bits%==x64 (
		set forcex86=n
		echo Do you want to use 32-bit Version? [Y/N] [Default: NO]:
		echo.
		echo.
		set /p forcex86=
	)
	
)

if %forcex86%==Y set bits=x86
if %forcex86%==y set bits=x86
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: Check Operating System

:: Set Default OS
set ostype=windows

:: Check common OS versions
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

:: This is the new versioning for Windows 10 (Started sometime in 2015/2016)
ver | find "10."
if %errorlevel%==0 set ostype=win10
ver | find "10.0"
if %errorlevel%==0 set ostype=win10
ver | find "10.1"
if %errorlevel%==0 set ostype=win10
ver | find "10.2"
if %errorlevel%==0 set ostype=win10
ver | find "10.3"
if %errorlevel%==0 set ostype=win10
ver | find "10.4"
if %errorlevel%==0 set ostype=win10
ver | find "10.5"
if %errorlevel%==0 set ostype=win10
ver | find "10.6"
if %errorlevel%==0 set ostype=win10
ver | find "10.7"
if %errorlevel%==0 set ostype=win10
ver | find "10.8"
if %errorlevel%==0 set ostype=win10
ver | find "10.9"
if %errorlevel%==0 set ostype=win10
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: Check parent directory name (also sets module name)
set moduleNameTemp=%~p0
set moduleNameTemp=%moduleNameTemp:~1,-1%
set moduleNameTemp=%moduleNameTemp:\=,%
set moduleNameTemp=%moduleNameTemp: =_%
for %%a in (%moduleNameTemp%) do set "moduleActive=%%a"
set moduleActive=%moduleActive:_= %

:: Setting working directories
set extractedDir=%systemDrive%\PCLTEMP
set pclTempDir=%temp%\pcl\temp

:: If launched from PCL, global variables are not set and overwritten
if "%pclActive%"=="" (
set runDirectory=%cd%
set pclActive=0
)

:: Setting global directories if not present
set pclTempTemp=%temp%\pcl\temp
set pclTempMain=%temp%\pcl

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
set cookies=%AppData%\Microsoft\Windows\Cookies
set cookiesLow=%AppData%\Microsoft\Windows\Cookies\Low

:: Module Specific Items
set pathCoreLocalRun=%runDirectory%\run
if defined pathUpdatesLocalNameAU set pathUpdatesLocalAU=%au%\%pathUpdatesLocalNameAU%
if defined pathUpdatesLocalNameCU set pathUpdatesLocalCU=%appdata%\%pathUpdatesLocalNameCU%
if defined pathUpdatesLocalNameADL set pathUpdatesLocalADL=%adl%\%pathUpdatesLocalNameADL%
if defined pathUpdatesLocalNameADLL set pathUpdatesLocalADLL=%adl%\%pathUpdatesLocalNameADLL%
if defined pathUpdatesLocalNameTempAU set pathUpdatesLocalTempAU=%windir%\temp\%pathUpdatesLocalNameTempAU%
if defined pathUpdatesLocalNameTempCU set pathUpdatesLocalTempCU=%temp%\%pathUpdatesLocalNameTempCU%
if defined pathUpdatesLocalNameUsers set pathUpdatesLocalUsers=%userprofile%\%pathUpdatesLocalNameUsers%
if defined pathUpdatesLocalNameRoot set pathUpdatesLocalRoot=%systemdrive%\%pathUpdatesLocalNameRoot%
if defined pathUpdatesLocalNamePF set pathUpdatesLocalPF=%pf%\%pathUpdatesLocalNamePF%
if defined pathUpdatesLocalNameCF set pathUpdatesLocalCF=%cf%\%pathUpdatesLocalNameCF%

if %pclActive%==0 (
set pclExtract="%~dp0data\rar.exe" x -y
set pclCompress="%~dp0data\rar.exe" a -m5
set pclCompressBlob="%~dp0data\rar.exe" a -m5 -ep1
set pack7z="%pathCoreLocalRun%\dependencies\7z.exe" a -y -r
set packRar="%pathCoreLocalRun%\dependencies\rar.exe" a -m5
set packZip="%pathCoreLocalRun%\dependencies\zip.exe"
set unpack7z="%pathCoreLocalRun%\dependencies\7z.exe" -y x
set unpackRar="%pathCoreLocalRun%\dependencies\rar.exe" x -y
set unpackZip="%pathCoreLocalRun%\dependencies\unzip.exe"
set sevenZ="%pathCoreLocalRun%\dependencies\7z.exe"
set cocolor="%pathCoreLocalRun%\dependencies\cocolor.exe"
set inifile="%pathCoreLocalRun%\dependencies\inifile.exe"
set innoextract=%pathCoreLocalRun%\dependencies\innoextract.exe
set extractInno=%pathCoreLocalRun%\dependencies\innoextract.exe
set extractInnoSilent=%pathCoreLocalRun%\dependencies\innoextract.exe -q -s -d
set instsrv="%pathCoreLocalRun%\dependencies\instsrv.exe"
set md5sum="%pathCoreLocalRun%\dependencies\md5sums.exe" -b -e
set msgbox="%pathCoreLocalRun%\dependencies\msgbox.exe"
set msiexec=msiexec
set msiExtract=msiexec /a
set msiUninstall=msiexec /x
set nircmd="%pathCoreLocalRun%\dependencies\nircmd.exe"
set nop="%pathCoreLocalRun%\dependencies\nop.exe"
set rar="%pathCoreLocalRun%\dependencies\rar.exe"
set sfk="%pathCoreLocalRun%\dependencies\sfk.exe"
set srvany="%pathCoreLocalRun%\dependencies\srvany.exe"
set tail="%pathCoreLocalRun%\dependencies\tail.exe"
set taskkill="%pathCoreLocalRun%\dependencies\taskkill.exe"
set tasklist="%pathCoreLocalRun%\dependencies\tasklist.exe"
set unzip="%pathCoreLocalRun%\dependencies\unzip.exe"
set wait="%pathCoreLocalRun%\dependencies\wait.exe"
set wget="%pathCoreLocalRun%\dependencies\wget.exe"
set xml="%pathCoreLocalRun%\dependencies\xml.exe"
set zip="%pathCoreLocalRun%\dependencies\zip.exe"
)

:: File Commands (Unix-Like)
set cp=xcopy /e /y
set cp2=xcopy /y
set cp3=xcopy /e /y /h /d /c /r /i
set cp4=xcopy /e /y /h /d /c /r /i /s
set copy=copy /y
set copyNoClobber=copy
set del=del /f /q
set rm=del /f /q
set rmsubNoForce=del /s /q
set rmsub=del /f /s /q
set rmdir=rd /s /q
set mkdir=md
set kill=taskkill /f /im

:: Default Scanner EXE
set binScanner="%pathCoreLocalRun%\core\%appBin%"
::set binArgs=
set binUpdate="%pathCoreLocalRun%\core\%appBin%" /update
set binUpdateSilent="%pathCoreLocalRun%\core\%appBin%" /update -silent

:: Default Registry Files
set regeditImportFromFile=regedit /s
set regImportFromFile=reg import
set regExportToFile=reg export
set regAdd=reg add
set regDelete=reg delete
set regFileAdd="%pathCoreLocalRun%\registry\add.reg"
set regFileRemove="%pathCoreLocalRun%\registry\remove.reg"
set regFileRun="%pathCoreLocalRun%\registry\run.reg"
set regFileSvcAdd="%pathCoreLocalRun%\registry\svc_add.reg"
set regFileSvcAddSrvAny="%pathCoreLocalRun%\registry\svc_add_srvany.reg"
set regFileSvcRemove="%pathCoreLocalRun%\registry\svc_remove.reg"

:: Module Update Path For Copying New Updated Files Back To
set pathUpdateBlobs=%runDirectory%\data\blobs

:: Blob files running from default pclTempMain
if %bitSplit%==0 (
set blobCore="%pathUpdateBlobs%\core.blob"
set blobDependencies="%pathUpdateBlobs%\dependencies.blob"
if exist "%pathUpdateBlobs%\au.blob" set blobAllUsers="%pathUpdateBlobs%\au.blob"
if exist "%pathUpdateBlobs%\cu.blob" set blobCurrentUser="%pathUpdateBlobs%\cu.blob"
if exist "%pathUpdateBlobs%\adl.blob" set blobLocalAppData="%pathUpdateBlobs%\adl.blob"
if exist "%pathUpdateBlobs%\adll.blob" set blobLocalLowAppData="%pathUpdateBlobs%\adll.blob"
if exist "%pathUpdateBlobs%\tempau.blob" set blobTempAU="%pathUpdateBlobs%\tempau.blob"
if exist "%pathUpdateBlobs%\tempcu.blob" set blobTempCU="%pathUpdateBlobs%\tempcu.blob"
if exist "%pathUpdateBlobs%\users.blob" set blobUsers="%pathUpdateBlobs%\users.blob"
if exist "%pathUpdateBlobs%\root.blob" set blobRoot="%pathUpdateBlobs%\root.blob"
if exist "%pathUpdateBlobs%\misc.blob" set blobMisc="%pathUpdateBlobs%\misc.blob"
if exist "%pathUpdateBlobs%\registry.blob" set blobRegistry="%pathUpdateBlobs%\registry.blob"
)

if %bitSplit%==1 (
set blobCore="%pathUpdateBlobs%\core-%bits%.blob"
set blobDependencies="%pathUpdateBlobs%\dependencies.blob"
if exist "%pathUpdateBlobs%\au-%bits%.blob" set blobAllUsers="%pathUpdateBlobs%\au-%bits%.blob"
if exist "%pathUpdateBlobs%\cu-%bits%.blob" set blobCurrentUser="%pathUpdateBlobs%\cu-%bits%.blob"
if exist "%pathUpdateBlobs%\adl-%bits%.blob" set blobLocalAppData="%pathUpdateBlobs%\adl-%bits%.blob"
if exist "%pathUpdateBlobs%\adll-%bits%.blob" set blobLocalLowAppData="%pathUpdateBlobs%\adll-%bits%.blob"
if exist "%pathUpdateBlobs%\tempau-%bits%.blob" set blobTempAU="%pathUpdateBlobs%\tempau-%bits%.blob"
if exist "%pathUpdateBlobs%\tempcu-%bits%.blob" set blobTempCU="%pathUpdateBlobs%\tempcu-%bits%.blob"
if exist "%pathUpdateBlobs%\users.blob" set blobUsers="%pathUpdateBlobs%\users.blob"
if exist "%pathUpdateBlobs%\root.blob" set blobRoot="%pathUpdateBlobs%\root.blob"
if exist "%pathUpdateBlobs%\misc.blob" set blobMisc="%pathUpdateBlobs%\misc.blob"
if exist "%pathUpdateBlobs%\registry.blob" set blobRegistry="%pathUpdateBlobs%\registry.blob"
)

:: Set default kill process list
set killExe="%runDirectory%\data\kill.txt"

:: The GUI creates this file upon launch
set guiCheckFile="%windir%\temp\initGUI.txt"

:: Set debugMode to 0 if not defined
if not defined debugMode set debugMode=0

:: Get current date in YYYYMMDD format
setlocal enabledelayedexpansion
set dateTemp=!date:~10,4!!date:~4,2!!date:~7,2!
echo %dateTemp%>"%temp%\date.tmp"
endlocal
set /p dateReal=<"%temp%\date.tmp"
del /f /q "%temp%\date.tmp"

:: Set update date and time
set updateTimeDate=%date% %time%

::----------------------------------------------------------------------------------
:: END SETTING VARIABLES - ALL VARIABLES IN USE SHOULD BE SET AT THIS POINT!!
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: CHECKING FOR LOCAL AND BROKEN INSTALL
::----------------------------------------------------------------------------------
::set localBrokenCheck="BASE_FOLDER_OF_INSTALL"
::set localInstallCheck="UNIQUE_FILENAME_UNDER_BASE_FOLDER.exe"
::set broken=0
::set installed=0

::if exist %localInstallCheck% (
::set installed=1
::)

::if %installed%==0 (
::if exist %localBrokenCheck% set broken=1
::)

::if %broken%==0 goto chkLocal

::set remove=n
::cls
::echo Broken Install Detected!
::echo.
::echo.
::echo Remove It? [Y/N]:
::echo.
::set /p remove=
::if "%remove%"=="y" %rmdir% %localBrokenCheck%
::if "%remove%"=="Y" %rmdir% %localBrokenCheck%

:chkLocal
::if exist %localInstallCheck% (
::goto runLocal
::)
::----------------------------------------------------------------------------------
:: YOU SHOULD NOT CONTINUE FROM HERE UNLESS A LOCAL INSTALL IS NOT DETECTED!!!
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Creating folder structure on local drive
if not exist "%pathCoreLocalRun%" md "%pathCoreLocalRun%"
if defined blobAllUsers md "%pathUpdatesLocalAU%"
if defined blobCurrentUser md "%pathUpdatesLocalCU%"
if defined blobLocalAppData md "%pathUpdatesLocalADL%"
if defined blobLocalLowAppData md "%pathUpdatesLocalADLL%"
if defined blobCommonFiles md "%pathUpdatesLocalCF%"
if defined blobProgramFiles md "%pathUpdatesLocalPF%"
if defined blobTempAU md "%pathUpdatesLocalTempAU%"
if defined blobTempCU md "%pathUpdatesLocalTempCU%"
if defined blobUsers md "%pathUpdatesLocalUsers%"
if defined blobRoot md "%pathUpdatesLocalRoot%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract blobs needed to execute normally to a temp run folder
:: It is created inside the extracted module folder (%temp%\pcl\%moduleActive%\run\)
:: This folder is removed upon scanning completion to prepare for repack if needed
%pclExtract% %blobCore% "%pathCoreLocalRun%"
%pclExtract% %blobRegistry% "%pathCoreLocalRun%"
%pclExtract% %blobDependencies% "%pathCoreLocalRun%"
if defined blobMisc %pclExtract% %blobMisc% "%pathCoreLocalRun%"
if defined blobRegistry %pclExtract% %blobRegistry% "%pathCoreLocalRun%"

:: Extract blobs for AllUsers, CurrentUser, and Temp Paths
:: Only extract if needed for each module
if defined blobAllUsers %pclExtract% %blobAllUsers% "%au%"
if defined blobCurrentUser %pclExtract% %blobCurrentUser% "%appdata%"
if defined blobLocalAppData %pclExtract% %blobLocalAppData% "%adl%"
if defined blobLocalLowAppData %pclExtract% %blobLocalAppData% "%adll%"
if defined blobCommonFiles %pclExtract% %blobCommonFiles% "%cf%"
if defined blobProgramFiles %pclExtract% %blobProgramFiles% "%pf%"
if defined blobTempAU %pclExtract% %blobTempAU% "%windir%\temp"
if defined blobTempCU %pclExtract% %blobTempCU% "%temp%"
if defined blobUsers %pclExtract% %blobUsers% "%userprofile%"
if defined blobRoot %pclExtract% %blobRoot% "%systemdrive%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: ALL NEEDED FILES SHOULD BE AVAILABLE AT THIS POINT FOR LAUNCHING
::----------------------------------------------------------------------------------

:: Get random filename for launch (use for randomly named EXEs)
::set /p appBin=<"%pathCoreLocalRun%\core\random.get"
::set binScanner="%pathCoreLocalRun%\core\%appBin%"

if %debugMode%==1 pause

:: Set window title
title %appName% Portable Launcher %scriptVersion% :: portablecleaninglab.com

:: Checking if running from PCL menu or standalone launch
if "%pclActive%"=="" set runDirectory=%cd%

:: Setting up registry settings
%regImportFromFile% %regFileRun%

:: Override with any HKLM or HKCU registry files
%regImportFromFile% %regFileAddHKLM%
%regImportFromFile% %regFileAddHKCU%

::----------------------------------------------------------------------------------
:: Any services actions needed can be handled here

:: Service #1
::set service1Bin=.exe
::set service1Args=
::set service1Name=
::set service1DisplayName=
::set service1Description=
::set service1StartupType=demand
::set service1ErrorType=ignore

:: Service #2
::set service2Bin=.exe
::set service2Args=
::set service2Name=
::set service2DisplayName=
::set service2Description=
::set service2StartupType=demand
::set service2ErrorType=ignore

:: Service #3
::set service3Bin=.exe
::set service3Args=
::set service3Name=
::set service3DisplayName=
::set service3Description=
::set service3StartupType=demand
::set service3ErrorType=ignore

:: Service #4
::set service4Bin=.exe
::set service4Args=
::set service4Name=
::set service4DisplayName=
::set service4Description=
::set service4StartupType=demand
::set service4ErrorType=ignore

:: Create a service
::sc create "%service1Name%" binpath= "%pathCoreLocalRun%\core\%service1Bin% %service1Args%" start= %service1StartupType% DisplayName= "%service1DisplayName%" error= ignore
::sc create "%service2Name%" binpath= "%pathCoreLocalRun%\core\%service2Bin% %service2Args%" start= %service2StartupType% DisplayName= "%service2DisplayName%" error= ignore
::sc create "%service3Name%" binpath= "%pathCoreLocalRun%\core\%service3Bin% %service3Args%" start= %service3StartupType% DisplayName= "%service3DisplayName%" error= ignore
::sc create "%service4Name%" binpath= "%pathCoreLocalRun%\core\%service4Bin% %service4Args%" start= %service4StartupType% DisplayName= "%service4DisplayName%" error= ignore

:: Create a service (alternate)
:: DO NOT USE THIS WITH ABOVE NORMAL SERVICES SCRIPTING FOR CREATE
::instsrv.exe "%service1Name%" "%pathCoreLocalRun%\dependencies\srvany.exe"
::instsrv.exe "%service2Name%" "%pathCoreLocalRun%\dependencies\srvany.exe"
::instsrv.exe "%service3Name%" "%pathCoreLocalRun%\dependencies\srvany.exe"
::instsrv.exe "%service4Name%" "%pathCoreLocalRun%\dependencies\srvany.exe"

:: Add description
::sc description "%service1Name%" "%service1Description%"
::sc description "%service2Name%" "%service2Description%"
::sc description "%service3Name%" "%service3Description%"
::sc description "%service4Name%" "%service4Description%"

:: Start a service With Arguments
::sc start "%service1Name%" binpath= "%pathCoreLocalRun%\core\%service1Bin% %service1Args%"
::sc start "%service2Name%" binpath= "%pathCoreLocalRun%\core\%service2Bin% %service2Args%"
::sc start "%service3Name%" binpath= "%pathCoreLocalRun%\core\%service3Bin% %service3Args%"
::sc start "%service4Name%" binpath= "%pathCoreLocalRun%\core\%service4Bin% %service4Args%"

:: Start a service No Arguments
::sc start "%service1Name%" binpath= "%pathCoreLocalRun%\core\%service1Bin%"
::sc start "%service2Name%" binpath= "%pathCoreLocalRun%\core\%service2Bin%"
::sc start "%service3Name%" binpath= "%pathCoreLocalRun%\core\%service3Bin%"
::sc start "%service4Name%" binpath= "%pathCoreLocalRun%\core\%service4Bin%"
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: Write EXEs to kill.txt (use for randomly named EXEs)
::echo %appBin%>%killExe%
::echo otherEXE.exe>>%killExe%
::echo otherOtherEXE.exe>>%killExe%

:: Killing active processes
setlocal enabledelayedexpansion
set processList=0
for /f "tokens=*" %%a in (%killExe%) do (
    set /a processList=!processList! + 1
	%kill% "%%a"
)
endlocal
::----------------------------------------------------------------------------------


::----------------------------------------------------------------------------------
:: Launching App
cls
echo DO NOT CLOSE THIS WINDOW!!
echo.
echo.
::echo Last Update: %updateTimeDate%
echo.
echo.
if %bitSplit%==0 echo Launching %appName% Portable [%appVersion%]...
if %bitSplit%==1 echo Launching %appName% Portable [%appVersion%] %bits%...
echo.
echo.

:: Extract any last minute files (definitions, settings, etc)

:: Using ZIP
::%unpack7z% "%runDirectory%\data\blobs\FILE.ZIP" -o"%pathCoreLocalRun%"

:: Using RAR
::%unpackRar% %blobAllUsers% "%pathCoreLocalRun%"

:: Change to same directory as EXE so it unpacks in proper folder
::if %pclActive%==0 (
::cd "%pathCoreLocalRun%\core"
::)
::if %pclActive%==1 (
::chdir /d "%pclTempMain%\%moduleActive%\run\core"
::%wait% 2
::)

:: Set compatibility mode if needed before launch
::set __COMPAT_LAYER=WIN95
::set __COMPAT_LAYER=WIN98
::set __COMPAT_LAYER=WIN4SP5
::set __COMPAT_LAYER=WIN2000
::set __COMPAT_LAYER=WinXP
::set __COMPAT_LAYER=WINXPSP2
::set __COMPAT_LAYER=WINXPSP3
::set __COMPAT_LAYER=VISTARTM
::set __COMPAT_LAYER=VISTASP1
::set __COMPAT_LAYER=VISTASP2
::set __COMPAT_LAYER=WIN7RTM
::set __COMPAT_LAYER=WINSRV03SP1
::set __COMPAT_LAYER=WINSRV08SP1

:: Compatibility mode registry add
:: %regAdd% "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v %binUpdate% /t REG_SZ /d "WINXPSP3 RUNASADMIN" /f

:: Launch main EXE file Standalone with No Arguments
%binScanner%

:: Launch main EXE file with Arguments
::%binScanner% %binArgs%

:: Compatibility mode registry delete
:: %regDelete% "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers\%binUpdate%"
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: If using services then the next 2 commands need executed
:: Stop a service
::net stop %serviceName%

:: Delete a service
::sc delete "%serviceName%"
::----------------------------------------------------------------------------------

if %debugMode%==1 pause

::----------------------------------------------------------------------------------
:: Change back to launch directory and wait for termination
:: If using CD to change into active directory
::if %pclActive%==0 (
::cd "%~dp0"
::%wait% 2
::)
::if %pclActive%==1 (
::chdir /d "%pclTempMain%\%moduleActive%"
::%wait% 2
::)
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: Killing active processes
setlocal enabledelayedexpansion
set processList=0
for /f "tokens=*" %%a in (%killExe%) do (
    set /a processList=!processList! + 1
	%kill% "%%a"
)
endlocal
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: Removing registry settings
%regImportFromFile% %regFileRemove%

:: Deleting traces of use
%rmdir% %pathCoreLocalRun%
if defined pathUpdatesLocalAU %rmdir% %pathUpdatesLocalAU%
if defined pathUpdatesLocalCU %rmdir% %pathUpdatesLocalCU%
if defined pathUpdatesLocalADL %rmdir% %pathUpdatesLocalADL%
if defined pathUpdatesLocalADLL %rmdir% %pathUpdatesLocalADLL%
if defined pathUpdatesLocalCF %rmdir% %pathUpdatesLocalCF%
if defined pathUpdatesLocalPF %rmdir% %pathUpdatesLocalPF%
if defined pathUpdatesLocalTempAU %rmdir% %pathUpdatesLocalTempAU%
if defined pathUpdatesLocalTempCU %rmdir% %pathUpdatesLocalTempCU%
if defined pathUpdatesLocalUsers %rmdir% %pathUpdatesLocalUsers%
if defined pathUpdatesLocalRoot %rmdir% %pathUpdatesLocalRoot%
::----------------------------------------------------------------------------------

goto end

::----------------------------------------------------------------------------------
:: Running Local If Available

:runLocal

cls
echo Local Installation Found!
echo.
echo.
echo Now launching locally installed application....
echo.
%localInstallCheck%
%wait% 3

goto end
::----------------------------------------------------------------------------------


:end
::exit
