@echo off

:reset

color 0e

::----------------------------------------------------------------------------------
:: BEGIN SETTING VARIABLES
::----------------------------------------------------------------------------------

set scriptVersion=v2.3

::----------------------------------------------------------------------------------
:: THESE ARE THE ONLY VARIABLES NEEDED FOR GLOBAL COMPATIBILITY
set appName=Comodo Cleaning Essentials
set appBin=CCE.exe
set appVersion=2.4.28582.192
:: Next Line Only Needed If All Users Folder Is Used
::set pathUpdatesLocalNameAU=APPFOLDERNAMEHERE
:: Next Line Only Needed If Current User Folder Is Used
::set pathUpdatesLocalNameCU=APPFOLDERNAMEHERE
:: Next Line Only Needed If AppData Local Folder Is Used
::set pathUpdatesLocalNameADL=APPFOLDERNAMEHERE
:: Next Line Only Needed If PF Common Files Folder Is Used
::set pathUpdatesLocalNameCF=APPFOLDERNAMEHERE
:: Next Line Only Needed If Temp AU Folder Is Used
::set pathUpdatesLocalNameTempAU=APPFOLDERNAMEHERE
:: Next Line Only Needed If Temp CU Folder Is Used
::set pathUpdatesLocalNameTempCU=APPFOLDERNAMEHERE
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
::----------------------------------------------------------------------------------

::----------------------------------------------------------------------------------
:: Check Architecture Bits
set bits=x86
if not exist "C:\Program Files (x86)" set bits=x86
if exist "C:\Program Files (x86)" set bits=x64
if not exist "%windir%\SysWOW64" set bits=x86
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set bits=x64

:: If EXE needs terminated after repack, then this flag is set to 1
set binKill=0

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
set binScanner="%pathCoreLocalRun%\core\%bits%\%appBin%"
::set binArgs=-s "nv"
set binArgs=-s "m;c;r"
set binUpdate="%pathCoreLocalRun%\core\%bits%\%appBin%" /update
set binUpdateSilent="%pathCoreLocalRun%\core\%bits%\%appBin%" /update -silent

:: Default Registry Files
set regeditImportFromFile=regedit /s
set regImportFromFile=reg import
set regExportToFile=reg export
set regFileAdd="%pathCoreLocalRun%\registry\add.reg"
set regFileRemove="%pathCoreLocalRun%\registry\remove.reg"
set regFileRun="%pathCoreLocalRun%\registry\run.reg"
set regFileSvcAdd="%pathCoreLocalRun%\registry\svc_add.reg"
set regFileSvcAddSrvAny="%pathCoreLocalRun%\registry\svc_add_srvany.reg"
set regFileSvcRemove="%pathCoreLocalRun%\registry\svc_remove.reg"
set regFileAddHKLM="%pathCoreLocalRun%\registry\hkcu.reg"
set regFileAddHKCU="%pathCoreLocalRun%\registry\hklm.reg"

:: Module Update Path For Copying New Updated Files Back To
set pathUpdateBlobs=%runDirectory%\data\blobs

:: Blob files running from default pclTempMain
set blobCore="%pathUpdateBlobs%\core.blob"
set blobDependencies="%pathUpdateBlobs%\dependencies.blob"
if exist "%pathUpdateBlobs%\au.blob" set blobAllUsers="%pathUpdateBlobs%\au.blob"
if exist "%pathUpdateBlobs%\cu.blob" set blobCurrentUser="%pathUpdateBlobs%\cu.blob"
if exist "%pathUpdateBlobs%\adl.blob" set blobLocalAppData="%pathUpdateBlobs%\adl.blob"
if exist "%pathUpdateBlobs%\cf.blob" set blobCommonFiles="%pathUpdateBlobs%\cf.blob"
if exist "%pathUpdateBlobs%\pf.blob" set blobProgramFiles="%pathUpdateBlobs%\pf.blob"
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

:: Last minute things to do
:: Useful if checking for a file created to know updates are finished
set defCheckFileTemp=bases.$$$
::set defCheckFileComplete=\Data\CCE\Logs

::----------------------------------------------------------------------------------
:: END SETTING VARIABLES - ALL VARIABLES IN USE SHOULD BE SET AT THIS POINT!!
::----------------------------------------------------------------------------------

:: Creating folder structure on local drive
if not exist "%pathCoreLocalRun%" md "%pathCoreLocalRun%"
if defined blobAllUsers md "%pathUpdatesLocalAU%"
if defined blobCurrentUser md "%pathUpdatesLocalCU%"
if defined blobLocalAppData md "%pathUpdatesLocalADL%"
if defined blobCommonFiles md "%pathUpdatesLocalCF%"
if defined blobProgramFiles md "%pathUpdatesLocalPF%"
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
if defined blobCommonFiles %pclExtract% %blobCommonFiles% "%cf%"
if defined blobProgramFiles %pclExtract% %blobProgramFiles% "%pf%"
if defined blobTempAU %pclExtract% %blobTempAU% "%windir%\temp"
if defined blobTempCU %pclExtract% %blobTempCU% "%temp%"

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

:: Override with any HKLM or HKCU registry files
%regImportFromFile% %regFileAddHKLM%
%regImportFromFile% %regFileAddHKCU%

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

:: Download remote file to RUN FOLDER pre-launch
::%wget% -O "%pathCoreLocalRun%\%localFile%" "%remoteFile%"
::%wget% -O "%pathCoreLocalRun%\%localFile64%" "%remoteFile64%"
::%wget% -O "%pathCoreLocalRun%\%localFileScanner%" "%remoteFileScanner%"
::%wget% -O "%pathCoreLocalRun%\%localFileDefinitions%" "%remoteFileDefinitions%"

:: Change to same directory as EXE so it unpacks in proper folder
::if %pclActive%==0 (
::cd "%pathCoreLocalRun%\core"
::)
::if %pclActive%==1 (
::chdir /d "%pclTempMain%\%moduleActive%\run\core"
::%wait% 2
::)

:: Launch main EXE file Standalone with No Arguments
::%binUpdate%

:: Launch main EXE file with Arguments
::%binScanner% %binArgs%

if %debugMode%==1 pause

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

::----------------------------------------------------------------------------
:: Download html page to file
::%wget% -O "%pathCoreLocalRun%\HTML.FILE" "http://www.scannerurlgoeshere.com"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Run a counter until version is available
::set counterURL=http://www.website.com/update/definitions
::set counterVer=0

:reRun
::%wget% -O "%pathCoreLocalRun%\definitions.zip" "%counterURL%%counterVer%.zip"
::set wgetError=%errorlevel%
::if %wgetError%==1 (
::set /a counterVer=%counterVer%+1
::goto reRun
::)
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Parse HTML for SCANNER FILE

:: Set variable names and local info (matches defaults)
::set localFileScanner=scanner.zip

:: Set variables for definitions
::set baseURL=http://website.com/update/definitions
::set baseName=scannerPreNumber-

:: Direct Link for reference
:: http://website.com/update/scanner/definitionsPreNumber-999.zip

:: Download file to parse from webpage
::set pageToParse=http://website.com/update/scanner
::%wget% -F -O "%pathCoreLocalRun%\pclParse.html" "%pageToParse%"

:: Get text from HTML file
::setlocal ENABLEDELAYEDEXPANSION

::set pclParseFile="%pathCoreLocalRun%\pclParse.html"
::set pclParseFileTemp="%pathCoreLocalRun%\pclParseTemp.html"
::%sfk% find %pclParseFileTemp% zip>%pclParseFile%
::for /f "tokens=*" %%a in (%pclParseFile%) do (
::	for /f "tokens=6 delims=/" %%b in (%%a) do (
::	set newLinkTemp=%%b
::	)
::)

:: Set new name for download
::set newLinkFull=%newLinkTemp:~0,-13%
::set newLinkChopped=%newLinkFull:~0,0%
::set newVer=%newLinkChopped:~-16,-18%

:: Set remote scanner file (matches defaults)
::set remoteFileScanner=%baseURL%/%baseName%%newVer%.zip

:: Quick fix to use full name
::set remoteFileScanner=%baseURL%/%newLinkFull%

:: Write url to text file
::echo %remoteFileScanner%>"%pathCoreLocalRun%\pclURLTemp.txt"

::endlocal

:: Retrieve url from text file
::set /p remoteFileScanner=<"%pathCoreLocalRun%\pclURLTemp.txt"

:: Remove temp parse HTML files
::%rm% "%pathCoreLocalRun%\pclParse.html"
::%rm% "%pathCoreLocalRun%\pclParseTemp.html"
::%rm% "%pathCoreLocalRun%\pclURLTemp.txt"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Parse HTML for DEFINITIONS FILE

:: Set variable names and local info (matches defaults)
:: Using scanner.zip here because ...well, its a scanner
set localFileDefinitions=scanner.zip
set localFileDefinitions64=scanner64.zip

:: Set variables for definitions
set baseURL=http://download.comodo.com/cce/download/setups
set baseName=cce_
:: Updated to check and use either 32/64 bit
set postName=_%bits%.zip

:: Direct Link for reference
:: http://download.comodo.com/cce/download/setups/cce_1.6.183539.73_x32.zip

:: Download file to parse from webpage
set pageToParse=https://www.comodo.com/home/download/during-download.php?prod=CCE
%wget% --no-check-certificate -F -O "%pathCoreLocalRun%\pclParseTemp.html" "%pageToParse%"

:: Get text from HTML file
setlocal ENABLEDELAYEDEXPANSION

set pclParseFile="%pathCoreLocalRun%\pclParse.html"
set pclParseFileTemp="%pathCoreLocalRun%\pclParseTemp.html"
%sfk% find %pclParseFileTemp% zip>%pclParseFile%
for /f "tokens=*" %%a in (%pclParseFile%) do (
	for /f "tokens=6 delims=/" %%b in (%%a) do (
	set newLinkTemp=%%b
	)
)

:: Set new name for download
:: FORCING BOTH 32 AND 64 BIT LINK CREATION (added 20150717)
set newLinkFull=%newLinkTemp:~0,-13%
set newLinkFull64Temp=%newLinkFull:~0,-6%
set newLinkFull64=%newLinkFull64Temp%64.zip
::set newLinkChopped=%newLinkFull:~0,0%
::echo newLinkFull: %newLinkFull%
::set newVer=%newLinkChopped:~-16,-18%

:: Set remote definitions file (matches defaults)
::set remoteFileDefinitions=%baseURL%/%baseName%%newVer%%postName%

:: Quick fix to use full name
set remoteFileDefinitions=%baseURL%/%newLinkFull%
set remoteFileDefinitions64=%baseURL%/%newLinkFull64%


:: Write url to text file
echo %remoteFileDefinitions%>"%pathCoreLocalRun%\pclURLTemp.txt"
echo %remoteFileDefinitions64%>"%pathCoreLocalRun%\pclURLTemp64.txt"

endlocal

:: Retrieve url from text file
set /p remoteFileDefinitions=<"%pathCoreLocalRun%\pclURLTemp.txt"
set /p remoteFileDefinitions64=<"%pathCoreLocalRun%\pclURLTemp64.txt"

:: Remove temp parse HTML files
%rm% "%pathCoreLocalRun%\pclParse.html"
%rm% "%pathCoreLocalRun%\pclParseTemp.html"
%rm% "%pathCoreLocalRun%\pclURLTemp.txt"
%rm% "%pathCoreLocalRun%\pclURLTemp64.txt"
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
::%wget% -O "%pathCoreLocalRun%\%localFile%" "%remoteFile%"
::%wget% -O "%pathCoreLocalRun%\%localFile64%" "%remoteFile64%"
::%wget% -O "%pathCoreLocalRun%\%localFileScanner%" "%remoteFileScanner%"
%wget% --no-check-certificate -O "%pathCoreLocalRun%\%localFileDefinitions%" "%remoteFileDefinitions%"
%wget% --no-check-certificate -O "%pathCoreLocalRun%\%localFileDefinitions64%" "%remoteFileDefinitions64%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Download remote file with USER AGENT to RUN FOLDER
::%wget% %userAgent% -O "%pathCoreLocalRun%\%localFile%" "%remoteFile%"
::%wget% %userAgent% -O "%pathCoreLocalRun%\%localFile64%" "%remoteFile64%"
::%wget% %userAgent% -O "%pathCoreLocalRun%\%localFileScanner%" "%remoteFileScanner%"
::%wget% %userAgent% -O "%pathCoreLocalRun%\%localFileDefinitions%" "%remoteFileDefinitions%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Download remote file to CORE FOLDER
::%wget% -O "%pathCoreLocalRun%\core\%localFile%" "%remoteFile%"
::%wget% -O "%pathCoreLocalRun%\core\%localFile64%" "%remoteFile64%"
::%wget% -O "%pathCoreLocalRun%\core\%localFileScanner%" "%remoteFileScanner%"
::%wget% -O "%pathCoreLocalRun%\core\%localFileDefinitions%" "%remoteFileDefinitions%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Download remote with USER AGENT file to CORE FOLDER
::%wget% %userAgent% -O "%pathCoreLocalRun%\core\%localFile%" "%remoteFile%"
::%wget% %userAgent% -O "%pathCoreLocalRun%\core\%localFile64%" "%remoteFile64%"
::%wget% %userAgent% -O "%pathCoreLocalRun%\core\%localFileScanner%" "%remoteFileScanner%"
::%wget% %userAgent% -O "%pathCoreLocalRun%\core\%localFileDefinitions%" "%remoteFileDefinitions%"

::----------------------------------------------------------------------------
:: Extract File 7z
::%unpack7z% "%pathCoreLocalRun%\%localFile%" -o"%pathCoreLocalRun%\extracted"
::%unpack7z% "%pathCoreLocalRun%\%localFile64%" -o"%pathCoreLocalRun%\extracted"
::%unpack7z% "%pathCoreLocalRun%\%localFileScanner%" -o"%pathCoreLocalRun%\extracted"
if not exist "%pathCoreLocalRun%\extracted\x86" md "%pathCoreLocalRun%\extracted\x86"
%unpack7z% "%pathCoreLocalRun%\%localFileDefinitions%" -o"%pathCoreLocalRun%\extracted\x86"
if not exist "%pathCoreLocalRun%\extracted\x64" md "%pathCoreLocalRun%\extracted\x64"
%unpack7z% "%pathCoreLocalRun%\%localFileDefinitions64%" -o"%pathCoreLocalRun%\extracted\x64"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Compress File 7z
::%pack7z% "%pathCoreLocalRun%\%localFile%" "%pathCoreLocalRun%\core" -o"%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Overwrite any files over you need to now before launch
%rm% "%pathCoreLocalRun%\extracted\x86\CCE\scanners\bases.cav"
%rm% "%pathCoreLocalRun%\extracted\x64\CCE\scanners\bases.cav"

:: Now copying bases.cav update file from CORE root to current scanner folder
%copy% "%pathCoreLocalRun%\core\bases.cav" "%pathCoreLocalRun%\extracted\%bits%\CCE\scanners\bases.cav"
::----------------------------------------------------------------------------

:: Settle for a minute
%wait% 5

:: Also copy bases.cav to current architecture path
::%copy% "%pathCoreLocalRun%\extracted\bases.cav" "%pathCoreLocalRun%\extracted\%bits%\CCE\scanners\bases.cav" 

:: Launch exe now to trigger auto update from extracted folder
start "" "%pathCoreLocalRun%\extracted\%bits%\CCE\%appBin%" %binArgs%

::----------------------------------------------------------------------------
:: Window State Check
::%nircmd% win find 

::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Definition Repack Stuff with Check

:chkInit
cls
echo Waiting For Updates To Initialize and Download....
echo.
echo.
echo You can click PAUSE on the scanner if there are no updates
echo.
%wait% 30
if not exist "%pathCoreLocalRun%\extracted\%bits%\CCE\scanners\%defCheckFileTemp%" (
%wait% 5
)

:chkDL
cls
echo Waiting For Finalizing of Updates....
echo.
echo.
echo You can click PAUSE on the scanner if there are no updates
echo.
%wait% 15
if not exist "%pathCoreLocalRun%\extracted\%bits%\CCE\scanners\%defCheckFileTemp%" (
goto chkVerify
)

:: Force back if updating temp file EXISTS still
goto chkDL

:chkVerify
cls
echo Waiting For Finalizing of Updates....
echo.
echo.
echo You can click PAUSE on the scanner if there are no updates
echo.
%wait% 15
if exist "%pathCoreLocalRun%\extracted\%bits%\CCE\scanners\%defCheckFileTemp%" (
goto chkDL
)

if not exist "%pathCoreLocalRun%\extracted\%bits%\CCE\scanners\%defCheckFileTemp%" (
cls
echo Waiting For Finalizing of Updates....
echo.
echo This is only a temporary fix until a better check is implemented!
echo.
echo.
echo Press ENTER when updates have finished!
echo.
set /p finished=
)


set binKill=1
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Compress File 7z
::%pack7z% "%pathCoreLocalRun%\%localFile%" -o"%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract File RAR to CORE
::%rar% x -y "%pathCoreLocalRun%\%localFile%" -o"%pathCoreLocalRun%\core"
::%rar% x -y "%pathCoreLocalRun%\%localFile64%" -o"%pathCoreLocalRun%\core"
::%rar% x -y "%pathCoreLocalRun%\%localFileScanner%" -o"%pathCoreLocalRun%\core"
::%rar% x -y "%pathCoreLocalRun%\%localFileDefinitions%" -o"%pathCoreLocalRun%\core"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract File RAR to EXTRACTED
::if not exist "%pathCoreLocalRun%\extracted" md "%pathCoreLocalRun%\extracted"
::%rar% x -y "%pathCoreLocalRun%\%localFile%" -o"%pathCoreLocalRun%\extracted"
::%rar% x -y "%pathCoreLocalRun%\%localFile64%" -o"%pathCoreLocalRun%\extracted"
::%rar% x -y "%pathCoreLocalRun%\%localFileScanner%" -o"%pathCoreLocalRun%\extracted"
::%rar% x -y "%pathCoreLocalRun%\%localFileDefinitions%" -o"%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract File RAR to TEMP
::if not exist "%pathCoreLocalRun%\temp" md "%pathCoreLocalRun%\temp"
::%rar% x -y "%pathCoreLocalRun%\%localFile%" -o"%pathCoreLocalRun%\temp"
::%rar% x -y "%pathCoreLocalRun%\%localFile64%" -o"%pathCoreLocalRun%\temp"
::%rar% x -y "%pathCoreLocalRun%\%localFileScanner%" -o"%pathCoreLocalRun%\temp"
::%rar% x -y "%pathCoreLocalRun%\%localFileDefinitions%" -o"%pathCoreLocalRun%\temp"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Compress File RAR
::%rar% a -m5 "%pathCoreLocalRun%\%localFile%" "%pathCoreLocalRun%\core"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract MSI Installer
::msiexec /a "%pathCoreLocalRun%\%localFile%" /qb TARGETDIR="%pathCoreLocalRun%\extracted"
::msiexec /a "%pathCoreLocalRun%\%localFile64%" /qb TARGETDIR="%pathCoreLocalRun%\extracted"
::msiexec /a "%pathCoreLocalRun%\%localFileScanner%" /qb TARGETDIR="%pathCoreLocalRun%\extracted"
::msiexec /a "%pathCoreLocalRun%\%localFileDefinitions%" /qb TARGETDIR="%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract Inno Installer
::%extractInnoSilent% "%pathCoreLocalRun%\extracted" "%pathCoreLocalRun%\%localFile%"
::%extractInnoSilent% "%pathCoreLocalRun%\extracted" "%pathCoreLocalRun%\%localFile64%"
::%extractInnoSilent% "%pathCoreLocalRun%\extracted" "%pathCoreLocalRun%\%localFileScanner%"
::%extractInnoSilent% "%pathCoreLocalRun%\extracted" "%pathCoreLocalRun%\%localFileDefinitions%"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Copy Extracted MSI files back to CORE folder
::%mkdir% "%pathCoreLocalRun%\extracted\%msiExtractPathTemp%"
::%copy% "%pathCoreLocalRun%\extracted\%msiExtractPathTemp%\*" "%pathCoreLocalRun%\core"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Copy Extracted INNO files back to CORE folder
::%mkdir% "%pathCoreLocalRun%\extracted\app"
::%copy% "%pathCoreLocalRun%\extracted\app\*" "%pathCoreLocalRun%\core"
::----------------------------------------------------------------------------

::----------------------------------------------------------------------------
:: Extract Files ZIP
::%mkdir% "%pathCoreLocalRun%\core"
::%mkdir% "%pathCoreLocalRun%\extracted"
::%unzip% -o "%pathCoreLocalRun%\%localFile%" -d "%pathCoreLocalRun%\core"
::%unzip% -o "%pathCoreLocalRun%\%localFile%" -d "%pathCoreLocalRun%\extracted"
::----------------------------------------------------------------------------

:: Must kill here so scanning does not continue
if %binKill%==1 %kill% "%appBin%"
%wait% 5

::----------------------------------------------------------------------------
:: Remove old bases.cav files
%rm% "%pathCoreLocalRun%\extracted\x86\CCE\scanners\bases.cav"
%rm% "%pathCoreLocalRun%\extracted\x64\CCE\scanners\bases.cav"
%rm% "%pathCoreLocalRun%\core\x86\scanners\bases.cav"
%rm% "%pathCoreLocalRun%\core\x64\scanners\bases.cav"

:: Copy Extracted ZIP files back to CORE folder
if not exist "%pathCoreLocalRun%\core\x86" md "%pathCoreLocalRun%\core\x86"
%cp% "%pathCoreLocalRun%\extracted\x86\CCE" "%pathCoreLocalRun%\core\x86"
if not exist "%pathCoreLocalRun%\core\x64" md "%pathCoreLocalRun%\core\x64"
%cp% "%pathCoreLocalRun%\extracted\x64\CCE" "%pathCoreLocalRun%\core\x64"
::%cp% "%pathCoreLocalRun%\extracted\CCE\" "%pathCoreLocalRun%\core"
::%copy% "%pathCoreLocalRun%\extracted\bases.cav" "%pathCoreLocalRun%\core\bases.cav"
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
::%rm% "%pathUpdatesLocalAU%\FILE.EXT

:: Export any new registry entries that are needed before repack
::%regExportToFile% "HKLM\SOFTWARE\COMPANYNAMEHERE" %regFileAddHKLM% -y
::%regExportToFile% "HKCU\SOFTWARE\COMPANYNAMEHERE" %regFileAddHKCU% -y

:: Removing old blobs
%rm% %blobCore%
::%rm% %blobDependencies%
if defined blobAllUsers %rm% %blobAllUsers%
if defined blobCurrentUser %rm% %blobCurrentUser%
if defined blobLocalAppData %rm% %blobLocalAppData%
if defined blobCommonFiles %rm% %blobCommonFiles%
if defined blobProgramFiles %rm% %blobProgramFiles%
if defined blobTempAU %rm% %blobTempAU%
if defined blobTempCU %rm% %blobTempCU%
::%rm% %blobMisc%
%rm% %blobRegistry%

:: Compress new blobs
%pclCompressBlob% %blobCore% "%pathCoreLocalRun%\core"
::%pclCompressBlob% %blobDependencies% "%pathCoreLocalRun%\dependencies"
::%pclCompressBlob% %blobMisc% "%pathCoreLocalRun%\misc"
%pclCompressBlob% %blobRegistry% "%pathCoreLocalRun%\registry"

:: Old code NOT CHECKING IF PATH EXISTS which caused issues if path was removed
::if defined blobAllUsers %pclCompressBlob% %blobAllUsers% "%pathUpdatesLocalAU%"
::if defined blobCurrentUser %pclCompressBlob% %blobCurrentUser% "%pathUpdatesLocalCU%"
::if defined blobLocalAppData %pclCompressBlob% %blobLocalAppData% "%pathUpdatesLocalADR%"
::if defined blobTempAU %pclCompressBlob% %blobTempAU% "%pathUpdatesLocalTempAU%\%moduleActive%"
::if defined blobTempCU %pclCompressBlob% %blobTempCU% "%pathUpdatesLocalTempCU%\%moduleActive%"

:: New code to only repack if folder still exists
if exist "%pathUpdatesLocalAU%" %pclCompressBlob% %blobAllUsers% "%pathUpdatesLocalAU%"
if exist "%pathUpdatesLocalCU%" %pclCompressBlob% %blobCurrentUser% "%pathUpdatesLocalCU%"
if exist "%pathUpdatesLocalADR%" %pclCompressBlob% %blobLocalAppData% "%pathUpdatesLocalADR%"
if exist "%pathUpdatesLocalCF%" %pclCompressBlob% %blobCommonFiles% "%pathUpdatesLocalCF%"
if exist "%pathUpdatesLocalPF%" %pclCompressBlob% %blobProgramFiles% "%pathUpdatesLocalPF%"
if exist "%pathUpdatesLocalTempAU%\%moduleActive%" %pclCompressBlob% %blobTempAU% "%pathUpdatesLocalTempAU%\%moduleActive%"
if exist "%pathUpdatesLocalTempCU%\%moduleActive%" %pclCompressBlob% %blobTempCU% "%pathUpdatesLocalTempCU%\%moduleActive%"

::if %binKill%==1 %kill% "%appBin%"

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
if defined pathUpdatesLocalCF %rmdir% %pathUpdatesLocalCF%
if defined pathUpdatesLocalPF %rmdir% %pathUpdatesLocalPF%
if defined pathUpdatesLocalTempAU %rmdir% %pathUpdatesLocalTempAU%
if defined pathUpdatesLocalTempCU %rmdir% %pathUpdatesLocalTempCU%

