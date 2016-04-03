@echo off

:reset

color 0e

::----------------------------------------------------------------------------------
:: BEGIN SETTING VARIABLES
::----------------------------------------------------------------------------------

set scriptVersion=v2.1

::----------------------------------------------------------------------------------
:: THESE ARE THE ONLY VARIABLES NEEDED FOR GLOBAL COMPATIBILITY
set appName=RemoveIT Pro
set appBin=removeit.exe
set appVersion=30.9.2015
:: Next Line Only Needed If All Users Folder Is Used
::set pathUpdatesLocalNameAU=APPFOLDERNAMEHERE
:: Next Line Only Needed If Current User Folder Is Used
::set pathUpdatesLocalNameCU=APPFOLDERNAMEHERE
:: Next Line Only Needed If AppData Local Folder Is Used
::set pathUpdatesLocalNameADL=APPFOLDERNAMEHERE
:: Next Line Only Needed If Temp AU Folder Is Used
::set pathUpdatesLocalNameTempAU=APPFOLDERNAMEHERE
:: Next Line Only Needed If Temp AU Folder Is Used
::set pathUpdatesLocalNameTempCU=APPFOLDERNAMEHERE
:: Next Line Only Needed If Checking For Local Installation
::set pathUpdatesLocalNamePF=APPFOLDERNAMEHERE
:: Next Line Only Needed For MSI Extraction
::set msiExtractPathTemp=Program Files\APPFOLDERNAMEHERE

:: Default Update Settings for use with WGET
set remoteFile=http://www.incodesolutions.com/downloads/removeit_pro.exe
set localFile=removeit_pro.exe
::set remoteFile64=http://www.website.com/file64.zip
::set localFile64=file64.zip
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

:: Set update date and time
set updateTimeDate=%date% %time%

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

:: Module Specific Items
set pathCoreLocalRun=%runDirectory%\run
if defined pathUpdatesLocalNameAU set pathUpdatesLocalAU=%au%\%pathUpdatesLocalNameAU%
if defined pathUpdatesLocalNameCU set pathUpdatesLocalCU=%appdata%\%pathUpdatesLocalNameCU%
if defined pathUpdatesLocalNameADL set pathUpdatesLocalADL=%adl%\%pathUpdatesLocalNameADL%
if defined pathUpdatesLocalNameTempAU set pathUpdatesLocalTempAU=%windir%\temp\%pathUpdatesLocalNameTempAU%
if defined pathUpdatesLocalNameTempCU set pathUpdatesLocalTempCU=%temp%\%pathUpdatesLocalNameTempCU%
if defined pathUpdatesLocalNamePF set pathUpdatesLocalPF=%au%\%pathUpdatesLocalNamePF%

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
set regImportFromFile=reg import
set regFileAdd="%pathCoreLocalRun%\registry\add.reg"
set regFileRemove="%pathCoreLocalRun%\registry\remove.reg"
set regFileRun="%pathCoreLocalRun%\registry\run.reg"
set regFileSvcAdd="%pathCoreLocalRun%\registry\svc_add.reg"
set regFileSvcAddSrvAny="%pathCoreLocalRun%\registry\svc_add_srvany.reg"
set regFileSvcRemove="%pathCoreLocalRun%\registry\svc_remove.reg"

:: Module Update Path For Copying New Updated Files Back To
set pathUpdateBlobs=%runDirectory%\data\blobs

:: Blob files running from default pclTempMain
set blobCore="%pathUpdateBlobs%\core.blob"
set blobDependencies="%pathUpdateBlobs%\dependencies.blob"
if exist "%pathUpdateBlobs%\au.blob" set blobAllUsers="%pathUpdateBlobs%\au.blob"
if exist "%pathUpdateBlobs%\cu.blob" set blobCurrentUser="%pathUpdateBlobs%\cu.blob"
if exist "%pathUpdateBlobs%\adl.blob" set blobLocalAppData="%pathUpdateBlobs%\adl.blob"
if exist "%pathUpdateBlobs%\tempau.blob" set blobTempAU="%pathUpdateBlobs%\tempau.blob"
if exist "%pathUpdateBlobs%\tempcu.blob" set blobTempCU="%pathUpdateBlobs%\tempcu.blob"
if exist "%pathUpdateBlobs%\misc.blob" set blobMisc="%pathUpdateBlobs%\misc.blob"
if exist "%pathUpdateBlobs%\registry.blob" set blobRegistry="%pathUpdateBlobs%\registry.blob"

:: Set default kill process list
set killExe="%runDirectory%\data\kill.txt"

:: The GUI creates this file upon launch
set guiCheckFile="%windir%\temp\initGUI.txt"

:: Set debugMode to 0 if not defined
if not defined debugMode set debugMode=0

:: User Agents
:: Default User Agent
set userAgent=--user-agent="Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0"

:: Common User Agents
set userAgentFirefox=--user-agent="Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0"
set userAgentIE=--user-agent="Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 5.1; en-US)"

:: Firefox User Agents
set userAgentFirefoxLinux=--user-agent="Mozilla/5.0 (X11; Linux i586; rv:31.0) Gecko/20100101 Firefox/31.0"
set userAgentFirefoxMac=--user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10; rv:33.0) Gecko/20100101 Firefox/33.0"
set userAgentFirefoxWindows=--user-agent="Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0"

:: IE User Agents
set userAgentIE11=--user-agent="Mozilla/5.0 (compatible, MSIE 11, Windows NT 6.3; Trident/7.0;  rv:11.0) like Gecko"

:: Default Header
set header=--header="Accept: text/html"

::----------------------------------------------------------------------------------
:: END SETTING VARIABLES - ALL VARIABLES IN USE SHOULD BE SET AT THIS POINT!!
::----------------------------------------------------------------------------------

:: Creating folder structure on local drive
if not exist "%pathCoreLocalRun%" md "%pathCoreLocalRun%"
if defined blobAllUsers md "%pathUpdatesLocalAU%"
if defined blobCurrentUser md "%pathUpdatesLocalCU%"
if defined blobLocalAppData md "%pathUpdatesLocalADL%"
if defined blobTempAU md "%pathUpdatesLocalTempAU%"
if defined blobTempCU md "%pathUpdatesLocalTempCU%"

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
if defined blobTempAU %pclExtract% %blobTempAU% "%pathUpdatesLocalTempAU%"
if defined blobTempCU %pclExtract% %blobTempCU% "%pathUpdatesLocalTempCU%"

::----------------------------------------------------------------------------------
:: ALL NEEDED FILES SHOULD BE AVAILABLE AT THIS POINT FOR LAUNCHING
::----------------------------------------------------------------------------------

if %debugMode%==1 pause

:: Set window title
title %appName% Portable Launcher %scriptVersion% :: portablecleaninglab.com

:: Checking if running from PCL menu or standalone launch
if "%pclActive%"=="" set runDirectory=%cd%

:: Setting up registry settings
%regImportFromFile% %regFileRun%

:: Any services actions needed can be launched here
:: Create a service
::sc create "%serviceName%" binpath= "%runDirectory%\core\%appBin%" start= demand DisplayName= "%serviceDisplayName%" error= ignore

:: Create a service (alternate)
::instsrv.exe "%serviceName%" "%runDirectory%\dependencies\srvany.exe"

:: Start a service
::sc start "%serviceName%" binpath= "%runDirectory%\core\%appBin%"

:: Stop a service
::net stop %serviceName%

:: Delete a service
::sc delete "%serviceName%"

:: Killing active processes
setlocal enabledelayedexpansion
set processList=0
for /f "tokens=*" %%a in (%killExe%) do (
    set /a processList=!processList! + 1
	%kill% "%%a"
)
endlocal


:: Launching App
cls
echo DO NOT CLOSE THIS WINDOW!!
echo.
echo.
::echo Last Update: %updateTimeDate%
echo.
echo.
echo Updating %appName% Portable [%appVersion%]...
echo.
echo.

:: Extract any last minute files (definitions, settings, etc)

:: Using ZIP
::%unpack7z% "%runDirectory%\data\blobs\FILE.ZIP" -o"%pathCoreLocalRun%"

:: Using RAR
::%unpackRar% %blobAllUsers% "%pathCoreLocalRun%"

:: Launch main EXE file Standalone with No Arguments
::%binUpdate%

:: Launch main EXE file with Arguments
::%binScanner% %binArgs%

if %debugMode%==1 pause

::----------------------------------------------------------------------------
:: Download html page to file
::%wget% -O "%pathCoreLocalRun%\HTML.FILE" "http://www.scannerurlgoeshere.com"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Parse HTML
::set baseURL=http://www.parseurlgoeshere.com
::set baseName=

::%wget% -F -O "%pathCoreLocalRun%\pclParse.html" "%baseURL%"

::setlocal ENABLEDELAYEDEXPANSION

::set newLinkTempFile="%pathCoreLocalRun%\pclParse.html"
::for /f "tokens=*" %%a in (%newLinkTempFile%) do (
::	for /f "tokens=5 delims=/" %%b in (%%a) do (
::	set newLinkTemp1=%%b
::	)
::)

::set newLinkTemp2=%newLinkTemp1:~0,-2%
::set newVer=%newLinkTemp1:~-11,-6%
::set newLink=%baseURL%/%baseName%%newVer%.exe

::endlocal
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Download parsed file
::%wget% -O "%pathCoreLocalRun%\PARSED.FILE" "%newLink%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Remove downloaded file HTML PARSE
::%rm% "%pathCoreLocalRun%\pclParse.html"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Remove downloaded file
::%rm% "%pathCoreLocalRun%\%localFile%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Download remote file to RUN FOLDER
%wget% -O "%pathCoreLocalRun%\%localFile%" "%remoteFile%"
::%wget% -O "%pathCoreLocalRun%\%localFile64%" "%remoteFile64%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Download remote file with USER AGENT to RUN FOLDER
::%wget% %userAgent% -O "%pathCoreLocalRun%\%localFile%" "%remoteFile%"
::%wget% %userAgent% -O "%pathCoreLocalRun%\%localFile64%" "%remoteFile64%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Download remote file to CORE FOLDER
::%wget% -O "%pathCoreLocalRun%\core\%localFile%" "%remoteFile%"
::%wget% -O "%pathCoreLocalRun%\core\%localFile64%" "%remoteFile64%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Download remote with USER AGENT file to CORE FOLDER
::%wget% %userAgent% -O "%pathCoreLocalRun%\core\%localFile%" "%remoteFile%"
::%wget% %userAgent% -O "%pathCoreLocalRun%\core\%localFile64%" "%remoteFile64%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract File 7z
::%unpack7z% "%pathCoreLocalRun%\%localFile%" -o"%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Compress File 7z
::%pack7z% "%pathCoreLocalRun%\%localFile%" -o"%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract File RAR to EXTRACTED
::if not exist "%pathCoreLocalRun%\extracted" md "%pathCoreLocalRun%\extracted"
::%rar% x -y "%pathCoreLocalRun%\%localFile%" -o"%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract File RAR to TEMP
::if not exist "%pathCoreLocalRun%\temp" md "%pathCoreLocalRun%\temp"
::%rar% x -y "%pathCoreLocalRun%\%localFile%" -o"%pathCoreLocalRun%\temp"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Compress File RAR
::%rar% a -m5 "%pathCoreLocalRun%\%localFile%" "%pathCoreLocalRun%\core"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract MSI Installer
::msiexec /a "%pathCoreLocalRun%\%localFile%" /qb TARGETDIR="%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract Inno Installer
%extractInnoSilent% "%pathCoreLocalRun%\extracted" "%pathCoreLocalRun%\%localFile%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Copy Extracted MSI files back to CORE folder
::%mkdir% "%pathCoreLocalRun%\extracted\%msiExtractPathTemp%"
::%copy% "%pathCoreLocalRun%\extracted\%msiExtractPathTemp%\*" "%pathCoreLocalRun%\core"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Copy Extracted INNO files back to CORE folder
%mkdir% "%pathCoreLocalRun%\extracted\app"
%copy% "%pathCoreLocalRun%\extracted\app\*" "%pathCoreLocalRun%\core"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Copy Extracted ZIP files back to CORE folder
::%copy% "%pathCoreLocalRun%\extracted\*" "%pathCoreLocalRun%\core"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract Files ZIP
::%unzip% -o "%pathCoreLocalRun%\localFile" -d "%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Pack files ZIP
::%pack7z% "%pathCoreLocalRun%\definitions.zip" "%pathCoreLocalRun%\definitions\*" -o"%pathCoreLocalRun%\"
::%pack7z% "%pathCoreLocalRun%\scanner.zip" "%pathCoreLocalRun%\core\*" -o"%pathCoreLocalRun%\"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Repack files extracted by setup files
::%cp% "%extractedDir%\*" "%runDirectory%\data\"
::%rm% "%runDirectory%\data\DELETE.FILE"
::%rmdir2% "%extractedDir%"
::----------------------------------------------------------------------------

:: Check for update failure
::if exist "%pclTempDir%\%moduleName%\CHECK.FILE" set updateFail=0
::if not exist "%pclTempDir%\%moduleName%\CHECK.FILE" set updateFail=1

:: Do stuff depending on update status
::if %updateFail%==0 ::%cp% "%pclTempDir%\%moduleName%\definitions.zip" "%runDirectory%\data\definitions.zip"
::if %updateFail%==0 ::%rm% "%pclTempDir%\%moduleName%\definitions.zip"
::if %updateFail%==1 goto fail

:: Check 0-byte files
::set zeroByteFile=0
::for %%a in ("%runDirectory%\data\sav32sfx.exe") do (
::  if %%~za equ 0 (
::    set zeroByteFile=1
::    echo HALT! 0 BYTE FILE DETECTED!
::    pause
::  ) else (
::    goto ready
::  )
::)

:: Setup updates for repack
cls
echo DO NOT CLOSE THIS WINDOW!!
echo.
echo.
echo Applying New Updates...
echo.
echo.

:: Remove any needed files before repack

:: Deleting local.conf to supress any errors launching in the future
::%rm% "%pathUpdatesLocalAU%\FILE.EXT

:: Removing old blobs
%rm% %blobCore%
::%rm% %blobDependencies%
if defined blobAllUsers %rm% %blobAllUsers%
if defined blobCurrentUser %rm% %blobCurrentUser%
if defined blobLocalAppData %rm% %blobLocalAppData%
if defined blobTempAU %rm% %blobTempAU%
if defined blobTempCU %rm% %blobTempCU%
::%rm% %blobMisc%
::%rm% %blobRegistry%

:: Compress new blobs
%pclCompressBlob% %blobCore% "%pathCoreLocalRun%\core"
::%pclCompressBlob% %blobDependencies% "%pathCoreLocalRun%\dependencies"
if defined blobAllUsers %pclCompressBlob% %blobAllUsers% "%pathUpdatesLocalAU%"
if defined blobCurrentUser %pclCompressBlob% %blobCurrentUser% "%pathUpdatesLocalCU%"
if defined blobLocalAppData %pclCompressBlob% %blobLocalAppData% "%pathUpdatesLocalADR%"
if defined blobTempAU %pclCompressBlob% %blobTempAU% "%pathUpdatesLocalTempAU%\%moduleActive%"
if defined blobTempCU %pclCompressBlob% %blobTempCU% "%pathUpdatesLocalTempCU%\%moduleActive%"
::%pclCompressBlob% %blobMisc% "%pathCoreLocalRun%\misc"
::%pclCompressBlob% %blobRegistry% "%pathCoreLocalRun%\registry"

goto end


:fail

cls
echo Update Failed!
echo.
echo.
echo Try Again [Y/N]?:
echo.
echo.

set /p failOption=

if %failOption%==Y goto reset
if %failOption%==y goto reset

if %failOption%==N goto end
if %failOption%==n goto end

goto end


:end

:: Killing active processes
setlocal enabledelayedexpansion
set processList=0
for /f "tokens=*" %%a in (%killExe%) do (
    set /a processList=!processList! + 1
	%kill% "%%a"
)
endlocal

:: Removing registry settings
%regImportFromFile% %regFileRemove%

:: Deleting traces of use
%rmdir% %pathCoreLocalRun%
if defined pathUpdatesLocalAU %rmdir% %pathUpdatesLocalAU%
if defined pathUpdatesLocalCU %rmdir% %pathUpdatesLocalCU%
if defined pathUpdatesLocalADL %rmdir% %pathUpdatesLocalADL%
if defined pathUpdatesLocalTempAU %rmdir% %pathUpdatesLocalTempAU%
if defined pathUpdatesLocalTempCU %rmdir% %pathUpdatesLocalTempCU%

