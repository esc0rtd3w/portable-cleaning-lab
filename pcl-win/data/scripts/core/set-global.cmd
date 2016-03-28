@echo off

:: Portable Cleaning Lab Global Variables List

:: Maintained by esc0rtd3w



:: If a variable is set at 0 it is usually a good default for a blank setting

:: ---------------------------------------------------------------------------------------
:: System Level Queries To Help PCL Navigate

:: Check Architecture Bits
set bits=x86
if not exist "C:\Program Files (x86)" set bits=x86
if exist "C:\Program Files (x86)" set bits=x64
if not exist "%windir%\SysWOW64" set bits=x86
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set bits=x64

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
:: ---------------------------------------------------------------------------------------


:: ---------------------------------------------------------------------------------------
:: PCL Core Begins Here
:: ---------------------------------------------------------------------------------------
set mainVer=0.9.3
set textReleaseType=RC7
set debugMode=0

:: Set initial value for 0-byte file detection
set zeroByteFile=0

:: Setting default local and remote versions for text compare in update script
set pclLocalVersion=0.0.0
set pclRemoteVersion=0.0.0

:: INI Config Defaults
set msgNoShow=1
set titleText=Portable Cleaning Lab v%mainVer% %textReleaseType% :: portablecleaninglab.com
set messagePreparingToLoad=Preparing to load the Portable Cleaning Lab....
set pclMode=user
set pclMainScript=portable-cleaning-lab.cmd
set md5CreateToggle=0
set updateFailed=0
set updateFailLimit=5
set updateAttempts=0
set updateAttemptsRemaining=5

:: Used for changing module paths, i.e. PE Mode
set overrideModulePaths=0

:: Setting default no path to initialize
set pclModulesPath=0
set pclModulesCleaningScannersPath=0

:: This is used for letting the MsgBox appear only when invoking from Expert menu, not on launch if version matches
set initUpdate=0


set menuItem=999
set exitStatus=return

:: Default Update Params
set updateServer=http://portablecleaninglab.com
set updateServerBackup=http://pclupdate.com
set updateListServer=updateList.txt
set updatePath=.update
set remoteUpdatePath=.update
set remoteUpdatePathModulesCleaningScanners=data/modules/cleaning/scanners

:: Config pcl.ini hash and default values (added 20150704)
set configHashLocal=0
set configHashRemote=0
set configHashesMatch=0
set configCorruptionDetection=0

set updateRebootFlag=0
set disableUpdates=0
set disableUpdatesAuto=1

set pclConfigFileMainRemote=data/config/pcl.ini
set pclConfigFileMainLocal=data\config\pcl.ini

set pclReleaseBaseName=pcl-win
set pclReleaseBaseExt=zip
set pclReleasePath=release
set pclArchivePath=archive

:: Fixes an issue where Spybot, Clamwin and others trigger a double launch
set doubleLaunchFix=0

:: Used for module injection during active run
set inject=0
set injectStatus=0

set moduleActive=0

set pclLocalVersion=0.0.0
set pclRemoteVersion=0.0.0

set fileAccess=0

:: Check Safe Mode
set safeModeState=0
set safeModeCheck=1

:: Check PE Mode
set peModeState=0
set peModeCheck=1


:: This flag will change the runDirectory variable depending on if ran with or without PCL
:: If set to 1, the PCL initiated the module unpack and runDirectory will be "%pclTempMain%\pcl\%moduleActive%"
:: If running module as standalone, this value is set to 0 and runDirectory will be %cd% (default current directory)
set pclActive=1

:: These global variables are used to determine which directory and selected active name are
:: currently in use in order to make unpacking and using launch.cmd global across all possibilities
set globalPath=0
set globalActive=0
set globalMenu=0

set fixtype=0

set counterStatus=off
set counterMax=999

:: Scanner menu related
set scannerUpdateMode=default

set virtualDriveLetter=0

:: Define dump number var (on this machine) for forensic dumps
set dumpNumber=0


:: SYSTEM Related
set pclLaunchMode=user

set targetFile=0

:: Module Related
set moduleType=0
set moduleSubType=0
set moduleSubTypeLayers=0

:: Use this flag to not trigger the default launch.cmd from module
set supressModuleLaunch=0

:: Use this flag to not trigger the default update.cmd from module
set supressModuleUpdate=0

:: Set default UAC status
set uacStatus=Disabled

:: PCL Core Ends Here
:: ---------------------------------------------------------------------------------------



:: ---------------------------------------------------------------------------------------
:: Default Global Path Names Begin Here
:: These variables MUST be set before scripting is called
:: All scripting and binary functions MUST follow this section, NOT BEFORE IT!!!
:: ---------------------------------------------------------------------------------------

:: Default Paths
set pclRootPath=%rootDrive%\pcl-win
set pclBannerPath=%pclRootPath%\data\scripts\menu\banner
set pclBinPath=%pclRootPath%\data\bin
set pclDataPath=%pclRootPath%\data
set pclConfigPath=%pclRootPath%\data\config
set pclHelpPath=%pclRootPath%\data\scripts\menu\help
set pclKeywordsPath=%pclRootPath%\data\scripts\menu\keywords
set pclListsPath=%pclRootPath%\data\scripts\lists
set pclMenuPath=%pclRootPath%\data\scripts\menu

:: Module Paths
set pclModulesPath=%pclRootPath%\data\modules
set pclModulesCleaningScannersPath=%pclRootPath%\data\modules\cleaning\scanners

set pclRegistryPath=%pclRootPath%\data\registry
set pclScriptsPath=%pclRootPath%\data\scripts
set pclTextPath=%pclRootPath%\data\text
set pclUiPath=%pclRootPath%\data\scripts\ui
set pclUiPathAuto=%pclRootPath%\data\scripts\ui\auto
set pclUiPathEasy=%pclRootPath%\data\scripts\ui\easy
set pclUiPathExpert=%pclRootPath%\data\scripts\ui\expert
set pclUiPathForensics=%pclRootPath%\data\scripts\ui\forensics
set pclUninstallPath=%pclRootPath%\data\scripts\uninstall
set pclUpdatesPath=%pclRootPath%\data\updates
set pclUpdatesPathTemp=%pclRootPath%\data\scripts\updates

:: Scripting Environments For Menu
set pclConfigScriptPath=%pclRootPath%\data\scripts\config
set pclCoreScriptPath=%pclRootPath%\data\scripts\core
set pclDebugScriptPath=%pclRootPath%\data\scripts\debug
set pclFixesScriptPath=%pclRootPath%\data\scripts\fixes
set pclModulesScriptPath=%pclRootPath%\data\scripts\modules
set pclNetworkScriptPath=%pclRootPath%\data\scripts\network
set pclUpdatesScriptPath=%pclRootPath%\data\scripts\updates

:: Update Related
set localUpdatePath=%pclDataPath%\updates
set localUpdateCache=%pclDataPath%\updates\cache

:: Temp Paths

:: TEMP FIX for STANDALONE TESTING (20141228)
set tempGlobal=%temp%
set extractedDir=%systemDrive%\PCLTEMP
set pclTempDir=%tempGlobal%\pcl\temp


set pclTempUser=%tempGlobal%
set pclTempMain=%tempGlobal%\pcl
set pclTempTemp=%tempGlobal%\pcl\temp
set pclTempBlobs=%tempGlobal%\pcl\temp\blobs
set pclTempUpdates=%tempGlobal%\pcl\updates\temp
set pclModuleTempPath=%systemdrive%\temp
set standardWindowsTempPath=%windir%\temp

set pclModulesPathEdit="%pclTempMain%\moduleMain.path"
set pclModulesCleaningScannersPathEdit="%pclTempMain%\moduleCleaningScanners.path"

:: Use this to carry variables from USER to SYSTEM
set pclCurrentEnvironment="%windir%\temp\pcl.set"

:: Unsorted Misc Paths
set files=data\bin
set pathCleaning=data\cleaning
set pathDiagnostics=data\diagnostics
set pathMaintenance=data\maintenance
set pathScanners=data\scanners
set pathUtilities=data\utilities

:: Config Files
:: These 2 are used for instances where the full path is not needed
:: Its a little sloppy but it can stay for now 20141128
set configPath=data\config
set config=data\config\pcl.ini

:: Common OS Paths
set pf=%systemdrive%\Program Files
set cf=%systemdrive%\Program Files\Common Files
set pf64=%systemdrive%\Program Files (x86)
set cf64=%systemdrive%\Program Files (x86)\Common Files
set pd=%ProgramData%
set pdxp=%UserProfile%\Application Data\
set adl=%LocalAppData%
set adll=%SystemDrive%%HomePath%\AppData\LocalLow
set adr=%AppData%
set au=%SystemDrive%\All Users
set auxp=%systemdrive%\Documents and Settings\All Users
set cu=%UserProfile%
set cuxp=%userprofile%\Application Data
set win=%windir%
set sys32=%windir%\system32
set sysprofile=%windir%\system32\config\systemprofile
set userdir=%userprofile%
set cookies=%AppData%\Microsoft\Windows\Cookies

:: Temp Paths
set temp1=%tempGlobal%
set temp2=%systemdrive%\Temp
set temp3=%windir%\Temp
set temp4=%windir%\system32\config\systemprofile\AppData\Local\Temp
set tempInit=%tempGlobal%
set tempDirectory=%tempInit%
set tempSys=%windir%\TEMP

:: Desktop Paths
set deskau=%public%\Desktop
set deskcu=%SystemDrive%%HomePath%\Desktop

:: Start Menu Paths
set startau=%systemdrive%\Users\All Users\Microsoft\Windows\Start Menu\Programs
set startcu=%AppData%\Microsoft\Windows\Start Menu\Programs

:: Documents Paths
set docsau=%Public%\Documents
set docscu=%UserProfile%\Documents

:: Misc paths used in backup routine (may be unreferenced)
set user=%UserProfile%
set appdata2=%user%\AppData

:: Default Common User Paths
set contacts=%UserProfile%\Contacts
set desktop=%UserProfile%\Desktop
set mydownloads=%UserProfile%\Downloads
set favorites=%UserProfile%\Favorites
set links=%UserProfile%\Links
set mydocuments=%UserProfile%\My Documents
set mymusic=%UserProfile%\My Music
set mypictures=%UserProfile%\My Pictures
set myvideos=%UserProfile%\My Videos
set savedgames=%UserProfile%\Saved Games
set searches=%UserProfile%\Searches

:: Alternate Default Common User Paths
set documents=%UserProfile%\Documents
set downloads=%UserProfile%\Downloads
set pictures=%UserProfile%\Pictures
set music=%UserProfile%\Music
set videos=%UserProfile%\Videos

:: System User Paths
set sysUserRoot=%windir%\system32\config\systemprofile
set sysUserAppData=%windir%\system32\config\systemprofile\AppData
set sysUserAppDataLocal=%windir%\system32\config\systemprofile\AppData\Local
set sysUserAppDataLocalLow=%windir%\system32\config\systemprofile\AppData\LocalLow
set sysUserAppDataRoaming=%windir%\system32\config\systemprofile\AppData\Roaming
set sysUserDesktop=%windir%\system32\config\systemprofile\Desktop
set sysUserDocuments=%windir%\system32\config\systemprofile\Documents
set sysUserDownloads=%windir%\system32\config\systemprofile\Downloads
set sysUserFavorites=%windir%\system32\config\systemprofile\Favorites
set sysUserMusic=%windir%\system32\config\systemprofile\Music
set sysUserPictures=%windir%\system32\config\systemprofile\Pictures
set sysUserVideos=%windir%\system32\config\systemprofile\Videos

:: Default Global Path Names End Here
:: ---------------------------------------------------------------------------------------


:: ---------------------------------------------------------------------------------------
:: Path Names Only Begin Here
:: ---------------------------------------------------------------------------------------
:: Common Path Names
set contactsDirName=Contacts
set desktopDirName=Desktop
set downloadsDirName=Downloads
set favoritesDirName=Favorites
set linksDirName=Links
set mydocumentsDirName=My Documents
set mymusicDirName=My Music
set mypicturesDirName=My Pictures
set myvideosDirName=My Videos
set savedgamesDirName=Saved Games
set searchesDirName=Searches

:: Path Names Only Begin Here
:: ---------------------------------------------------------------------------------------


:: ---------------------------------------------------------------------------------------
:: Function Emulation Starts Here

:: Template for "Linux Function Emulation" by using variables to call scripts
::set reallyCoolNameHere=call "%pclScriptsPath%\myscript.cmd"
:: ---------------------------------------------------------------------------------------

:: Force navigation to the highest it can go to see base drive path
set getHigh=call "%pclCoreScriptPath%\get-high.cmd"

:: Banners
set bannerMenuDefault=call "%pclBannerPath%\default.cmd"

:: Main UI Mode Menu
set checkUiMode=call "%pclCoreScriptPath%\check-ui-mode.cmd"
set setUiMode=call "%pclCoreScriptPath%\set-ui-mode.cmd"
set setUiModeDefault=call "%pclCoreScriptPath%\set-ui-mode-default.cmd"
set setUiModeOverride=call "%pclCoreScriptPath%\set-ui-mode-override.cmd"
set switchUiMode=call "%pclCoreScriptPath%\switch-ui-mode.cmd"

:: UI Modes for in-menu switching
set uiModeAuto=call "%pclUiPathAuto%\main.cmd"
set uiModeEasy=call "%pclUiPathEasy%\main.cmd"
set uiModeExpert=call "%pclUiPathExpert%\main.cmd"
set uiModeForensics=call "%pclUiPathForensics%\main.cmd"

:: System Related
set pclCurrentEnvironmentBatch="%windir%\temp\systemInit.cmd"

:: Network Related
set checkNetworkStatus=call "%pclScriptsPath%\check-network.cmd"

:: Core
set setTargetDrive=call "%pclCoreScriptPath%\set-target-drive.cmd"
set checkUAC=call "%pclCoreScriptPath%\check-uac.cmd"
set checkBits=call "%pclCoreScriptPath%\check-bits.cmd"
set checkOS=call "%pclCoreScriptPath%\check-os.cmd"
set checkForSafeMode=call "%pclCoreScriptPath%\check-safe-mode.cmd"
set checkForPeMode=call "%pclCoreScriptPath%\check-pe-mode.cmd"
set getLocalConfig=call "%pclCoreScriptPath%\get-local-config.cmd"
set createLocalTempDirectoryStructure=call "%pclCoreScriptPath%\create-directory-structure.cmd"
set killTheLingering=call "%pclCoreScriptPath%\kill-the-lingering.cmd"
set pclCurrentEnvironmentReadToBatch=call "%pclCoreScriptPath%\read-current-environment.cmd"
set checkFileAccess=call "%pclCoreScriptPath%\check-rw-permissions.cmd"
set checkFileAccessSelect=call "%pclCoreScriptPath%\check-rw-permissions-select.cmd"
set preCleanAllFiles=call "%pclCoreScriptPath%\preclean.cmd"
set postCleanAllFiles=call "%pclCoreScriptPath%\postclean.cmd"
set displayVersionInfo=call "%pclCoreScriptPath%\display-version-info.cmd"
set checkForZeroByteFile=call "%pclCoreScriptPath%\check-zerobyte-files.cmd"

:: Archiving Related
set unpackUpxAuto=call "%pclCoreScriptPath%\unpack-upx.cmd"

:: System Elevation
set elevatePclToSystem=call "%pclCoreScriptPath%\elevate-pcl-to-system.cmd"
set elevatePrivsToSystem=call "%pclCoreScriptPath%\elevate-privs-to-system.cmd"

:: VBScript Style MessageBox
set msgboxVB="%pclCoreScriptPath%\msgboxVB.cmd"

:: Virtual Temp Drive Related
set getNextAvailableDriveLetter=call "%pclCoreScriptPath%\get-next-available-drive-letter.cmd"
set setNextAvailableDriveLetter=call "%pclCoreScriptPath%\set-next-available-drive-letter.cmd"

:: INI Config Stuff
set checkIniFiles=call "%pclConfigScriptPath%\check-ini-files.cmd"
set iniRead=call "%pclConfigScriptPath%\read-ini.cmd"
set iniWrite=call "%pclConfigScriptPath%\write-ini.cmd"
set iniVerifyMainConfig="%pclConfigScriptPath%\verify-main.cmd"
set iniReadTempFile="%pclTempMain%\iniReadTemp.cmd"
set iniWriteTempFile="%pclTempMain%\iniWriteTemp.cmd"

:: Updates
set checkForUpdates=call "%pclUpdatesScriptPath%\check-for-updates.cmd"
set downloadUpdateFiles=call "%pclUpdatesScriptPath%\download-updates.cmd"
set parseUpdateFiles=call "%pclUpdatesScriptPath%\parse-update-files.cmd"
set unpackUpdatesRelease=call "%pclUpdatesScriptPath%\unpack-updates-release.cmd"
set buildUpdateList=call "%pclUpdatesScriptPath%\build-update-list.cmd"
set buildUpdateMD5List=call "%pclUpdatesScriptPath%\build-update-md5-list.cmd"
set clearUpdateCache=call "%pclUpdatesScriptPath%\clear-update-cache.cmd"

:: Module Actions
:: This One Is Special (gets launched, not called, so both the script and module can run together)
set injectIntoActiveModule=start cmd /k "%pclModulesScriptPath%\inject-into-active-module.cmd"

set downloadActiveModule=call "%pclModulesScriptPath%\download-active-module.cmd"
set processActiveModule=call "%pclModulesScriptPath%\process-active-module.cmd"
set repackActiveModule=call "%pclModulesScriptPath%\repack-active-module.cmd"
set runActiveModule=call "%pclModulesScriptPath%\run-active-module.cmd"
set runActiveModuleAuto=call "%pclModulesScriptPath%\run-active-module-auto.cmd"
set unpackActiveModule=call "%pclModulesScriptPath%\unpack-active-module.cmd"
set updateActiveModule=call "%pclModulesScriptPath%\update-active-module.cmd"

:: Unsorted
set clearAndResetPrinterQueue=call "%pclScriptsPath%\clear-printer-queue.cmd"
set clearAllTasks=call "%pclScriptsPath%\clear-tasks.cmd"

:: Debug Mode Related
set debugModeRun=call "%pclDebugScriptPath%\debug-main.cmd"

:: Forensics Related
set detectFalseUninstallers=call "%pclUiPathForensics%\detect-false-uninstallers.cmd"
set findBaddies=call "%pclUiPathForensics%\find-baddies.cmd"
set getPathFromProcess=call "%pclUiPathForensics%\get-path-from-process.cmd"

:: Function Emulation Ends Here
:: ---------------------------------------------------------------------------------------


:: ---------------------------------------------------------------------------------------
:: File Variables and References To Files Begin Here
:: ---------------------------------------------------------------------------------------

:: The GUI creates this file upon launch
set guiCheckFile="%windir%\temp\pclDebug.gui"

set testFile="%pclScriptsPath%\rwcheck.tmp"

::set /p currentLocalUser=<"%windir%\temp\currentLocalUser.id"
::set /p currentLocalUserProfile=<"%windir%\temp\currentLocalUserProfile.id"
::set /p currentADL=<"%windir%\temp\currentADL.id"

set openFolder="%windir%\explorer.exe"

:: Virtual Drive Letter Related
set /p virtualDriveLetter=<"%pclTempMain%\pclModuleTempDriveLetter.tmp"
set virtualDriveLetter=%virtualDriveLetter%:
set virtualTempDriveCreate=subst %virtualDriveLetter% "%pclModuleTempPath%"
set virtualTempDriveDestroy=subst %virtualDriveLetter% /d

:: MD5 Hashing Related
set updateList="%pclUpdatesPath%\updateList.txt"
set updateListMD5="%pclUpdatesPath%\updateListMD5.txt"
set updateListMD5Temp="%pclUpdatesPath%\updateListMD5Temp.txt"
set updateListMD5TempClean="%pclUpdatesPath%\updateListMD5TempClean.txt"
set updateListMD5TempClean2="%pclUpdatesPath%\updateListMD5TempClean2.txt"

set updateListFromTemp="%pclUpdatesPath%\cache\updateList.txt"
set updateListMD5FromTemp="%pclUpdatesPath%\cache\updateListMD5.txt"
set updateListMD5TempFromTemp="%pclUpdatesPath%\cache\updateListMD5Temp.txt"
set updateListMD5TempCleanFromTemp="%pclUpdatesPath%\cache\updateListMD5TempClean.txt"
set updateListMD5TempClean2FromTemp="%pclUpdatesPath%\cache\updateListMD5TempClean2.txt"

:: Time and Date Stuff
setlocal enabledelayedexpansion
set currentDate=!date:~10,4!!date:~4,2!!date:~7,2!
set currentTime=!time:~0,2!!time:~3,2!!time:~6,2!
echo %currentDate%>"%pclTempTemp%\date.id"
echo %currentTime%>"%pclTempTemp%\time.id"
endlocal

set /p currentDate=<"%pclTempTemp%\date.id"
set /p currentTime=<"%pclTempTemp%\time.id"
set currentDateTime=%currentDate%_%currentTime%

:: Dump Location Stuff
set dumpDateTime=%currentDate%_%currentTime%
set dumpPathCheckFile="%pclTempMain%\dump.path"

set pclDumpPathExternal=%rootDrive%\dumps\%username%-%dumpDateTime%

set pclDumpPathLocal=%AllUsersProfile%\pcl\dumps
::echo %AllUsersProfile%\pcl\dumps>%dumpPathCheckFile%
::set /p pclDumpPathLocal=<%dumpPathCheckFile%
set pclDumpPathLocalRegistry=%pclDumpPathLocal%\registry

:: Misc Module Stuff (Included In Standalone)
::set appName=APPNAMEHERE
::set appBin=app.exe
::set appVersion=0.0.0.0
::set pathUpdatesLocalNameAU=APPFOLDERNAMEHERE
::set pathUpdatesLocalNameCU=APPFOLDERNAMEHERE
::set pathUpdatesLocalTempAU=APPFOLDERNAMEHERE
::set pathUpdatesLocalTempCU=APPFOLDERNAMEHERE
::set pathUpdatesLocalNamePF=APPFOLDERNAMEHERE
::set msiExtractPathTemp=Program Files\APPFOLDERNAMEHERE

:: File Variables and References To Files End Here
:: ---------------------------------------------------------------------------------------



:: ---------------------------------------------------------------------------------------
:: Web Browser Paths
set browserAvant=Avant Browser\avant.exe
set browserChrome=Google\Chrome\Application\chrome.exe
set browserComodoDragon=Comodo\Dragon\dragon.exe
set browserComodoIceDragon=Comodo\IceDragon\icedragon.exe
set browserFirefox=Mozilla Firefox\firefox.exe
set browserFlock=Flock\flock.exe
set browserKMeleon=K-Meleon\k-meleon.exe
set browserMaxthon=Maxthon\Bin\Maxthon.exe
set browserNetscape=Netscape\Navigator 9\navigator.exe
set browserNetscape6=Netscape\Navigator 6\navigator.exe
set browserNetscape7=Netscape\Navigator 7\navigator.exe
set browserNetscape8=Netscape\Navigator 8\navigator.exe
set browserNetscape9=Netscape\Navigator 9\navigator.exe
set browserOpera=Opera\opera.exe
set browserSafari=Opera\safari.exe
set browserSeaMonkey=SeaMonkey\seamonkey.exe
set browserTorch=Torch\torch.exe

:: ---------------------------------------------------------------------------------------


:: ---------------------------------------------------------------------------------------
:: Commands and Custom References To Commands Start Here
:: ---------------------------------------------------------------------------------------

:: Files that are globally used in bin folder

:: Not using the number 7 first because of BATCH issues
set sevenz="%pclBinPath%\7z.exe"

set accesschk="%pclBinPath%\accesschk.exe"
set bintext="%pclBinPath%\bintext.exe"

set cabextract="%pclBinPath%\cabextract.exe"
set cabinfo="%pclBinPath%\cabinfo.exe"

set ccleaner="%pclBinPath%\ccleaner.exe"
set cdburn="%pclBinPath%\cdburn.exe"

:: Using the XP choice.exe for better compatibility
set choice="%pclBinPath%\choice.exe"

set cmdFocus="%pclBinPath%\cmdFocus.exe"
set cmsort="%pclBinPath%\cmsort.exe"
set cocolor="%pclBinPath%\cocolor.exe"
set dd="%pclBinPath%\dd.exe"
set diff="%pclBinPath%\diff.exe"
set diff3="%pclBinPath%\diff3.exe"
set driverquery="%pclBinPath%\driverquery.exe"
set dumphive="%pclBinPath%\dumphive.exe"
set exiftool="%pclBinPath%\exiftool.exe"
set openfile="%pclBinPath%\FileToOpen.exe"
set savefile="%pclBinPath%\FileToSave.exe"
set getsts="%pclBinPath%\getsts.exe"
set gpatch="%pclBinPath%\gpatch.exe"
set grep="%pclBinPath%\grep.exe"
set gzip="%pclBinPath%\gzip.exe"
set handle="%pclBinPath%\handle.exe"
set getHandles="%pclBinPath%\handle.exe" /accepteula
set hex2text="%pclBinPath%\hex2text.exe"
set inifile="%pclBinPath%\inifile.exe"

:: Use as %extractInno% %PathToExtract% %TargetInnoSetupFile%
set extractInno=%pclBinPath%\innoextract.exe
set extractInnoSilent=%pclBinPath%\innoextract.exe -q -s -d
set innounp="%pclBinPath%\innounp.exe"

set instsrv="%pclBinPath%\instsrv.exe"
set lzop="%pclBinPath%\lzop.exe"

:: Using md5.exe from fourmilab.ch/md5/
set md5="%pclBinPath%\md5.exe"
set md5sum="%pclBinPath%\md5.exe"

:: Using md5sums because of cygwin1.dll problems
::set md5sum="%pclBinPath%\md5sum.exe"
::set md5sum="%pclBinPath%\md5sums.exe" -b -e
set mdpview="%pclBinPath%\mdpview.exe"

set mkisofs="%pclBinPath%\mkisofs.exe"

:: MSI Stuff
set msiexec=msiexec
set msiExtract=msiexec /a
set msiUninstall=msiexec /x
set msicu="%pclBinPath%\msicu.exe"
set msicuu="%pclBinPath%\msicuu.exe"
set MsiZap="%pclBinPath%\MsiZap.exe"
set MsiZapA="%pclBinPath%\MsiZapA.exe"
set MsiZapU="%pclBinPath%\MsiZapU.exe"

set modifype="%pclBinPath%\modifype.exe"

:: Example %msgBox% %msgBoxText% %msgBoxTitle% %msgBoxStyleDefault%
:: Returns 7 if NO, 6 if YES, 2 if CANCEL, and 1 if OK
set msgBox="%pclBinPath%\msgbox.exe"
set msgBoxNoWait=start /min "" "%pclBinPath%\msgbox.exe"
set msgBoxText="Something happened here, but I'm not sure what it was!\n\nDont Worry, it's not dangerous!"
set msgBoxTitle="PCL v%mainVer%"
set msgBoxStyleDefault=
set msgBoxStyleOkCancel=OKCANCEL
set msgBoxStyleYesNo=YESNO
set msgBoxStyleYesNoCancel=YESNOCANCEL

set NBHextract="%pclBinPath%\NBHextract.exe"
set nop="%pclBinPath%\nop.exe"
set nssm="%pclBinPath%\nssm.exe"
set process="%pclBinPath%\process.exe"
set pv="%pclBinPath%\pv.exe"

set QuickRestorePoint="%pclBinPath%\QuickRestorePoint.exe"
set raiu="%pclBinPath%\raiu.exe"
set rar="%pclBinPath%\rar.exe"
set rammap="%pclBinPath%\rammap.exe"
set rawrite="%pclBinPath%\rawrite.exe"
set RegDeHexer="%pclBinPath%\RegDeHexer.exe"
set RegDelNull="%pclBinPath%\RegDelNull.exe"
set RegHexSee="%pclBinPath%\RegHexSee.exe"
set SafeMSI="%pclBinPath%\SafeMSI.exe"
set sed="%pclBinPath%\sed.exe"
set sfk="%pclBinPath%\sfk.exe"
set sleep="%pclBinPath%\sleep.exe"
set streams="%pclBinPath%\streams.exe"
set subinacl="%pclBinPath%\subinacl.exe"
set swreg="%pclBinPath%\swreg.exe"
set tail="%pclBinPath%\tail.exe"
set tar="%pclBinPath%\tar.exe"
set taskkill="%pclBinPath%\taskkill.exe"
set tasklist="%pclBinPath%\tasklist.exe"
set tee="%pclBinPath%\tee.exe"
set treecopy="%pclBinPath%\treecopy.exe"
set trid="%pclBinPath%\trid.exe"
set uniq="%pclBinPath%\uniq.exe"
set unlocker="%pclBinPath%\unlocker.exe"
set UnlockerInject32="%pclBinPath%\UnlockerInject32.exe"
set unlzx="%pclBinPath%\unlzx.exe"
set unrar="%pclBinPath%\unrar.exe"
set unzip="%pclBinPath%\unzip.exe"
set uudeview="%pclBinPath%\uudeview.exe"

:: UPX Stuff
set upx="%pclBinPath%\upx.exe"
set extractUPX="%pclBinPath%\upx.exe" -d -o
set upxTargetFile=0
set upxUnpackedFile=0

set wait="%pclBinPath%\wait.exe"
set Wbox="%pclBinPath%\Wbox.exe"
set Wbusy="%pclBinPath%\Wbusy.exe"
set Wfolder="%pclBinPath%\Wfolder.exe"
set Wfolder2="%pclBinPath%\Wfolder2.exe"
set wget="%pclBinPath%\wget.exe"
set wgetWithAltSave="%pclBinPath%\wget.exe" -O

set xcopy=xcopy /y
set xcopyNoClobber=xcopy
set xcopyFullPath=xcopy /e /y /h /d /c /r /i

set xml="%pclBinPath%\xml.exe"

:: YARA Malware Analysis
set yara32="%pclBinPath%\yara32.exe"
set yarac32="%pclBinPath%\yarac32.exe"
set yara64="%pclBinPath%\yara64.exe"
set yarac64="%pclBinPath%\yarac64.exe"

:: Setting psexec Commands
set psexec="%pclBinPath%\psexec.exe" /accepteula
set psexecElevateToSystem="%pclBinPath%\psexec.exe" /accepteula /ids cmd /c

::nircmd Stuff
set nircmd="%pclBinPath%\nircmd.exe"
set closeActiveWindowByTitle=%nircmd% win close title

set sendKey="%pclBinPath%\nircmd.exe" sendkey
set sendKeyEnter="%pclBinPath%\nircmd.exe" sendkey 0x0d press
set sendKeyTab="%pclBinPath%\nircmd.exe" sendkey 0x09 press
set sendKeyLeft="%pclBinPath%\nircmd.exe" sendkey 0x25 press
set sendKeyRight="%pclBinPath%\nircmd.exe" sendkey 0x27 press
set sendKeyUp="%pclBinPath%\nircmd.exe" sendkey 0x26 press
set sendKeyDown="%pclBinPath%\nircmd.exe" sendkey 0x28 press

set clickOkOnUACDialog="%pclBinPath%\nircmd.exe" dlg "UserAccountControlSettings.exe" "User Account Control Settings" click ok
set setres="%pclBinPath%\nircmd.exe" setdisplay 1024 768 24 90 -updatereg -allusers
set wasteTime="%pclBinPath%\nircmd.exe" wait 2000

:: Archiving Commands
:: The pclExtract without Module variables are obsolete and left in case they are still referenced, until tested further
set pclExtract="%pclBinPath%\rar.exe" x -y
set pclExtractNoClobber="%pclBinPath%\rar.exe" x
set pclExtractModule="%pclBinPath%\rar.exe" x -y
set pclExtractModuleNoClobber="%pclBinPath%\rar.exe" x
set pclCompress="%pclBinPath%\rar.exe" a -m5
set pclCompressExcludeBasePath="%pclBinPath%\rar.exe" a -m5 -ep1
set pclCompressBlob="%pclBinPath%\rar.exe" a -m5 -ep1

set pack7z="%pclBinPath%\7z.exe" a -y -r
set packRar="%pclBinPath%\rar.exe" a -m5
set packZip="%pclBinPath%\zip.exe"
set unpack7z="%pclBinPath%\7z.exe" -y x
set unpack7zNoClobber="%pclBinPath%\7z.exe" x
set unpackRar="%pclBinPath%\rar.exe" x -y
set unpackRarNoClobber="%pclBinPath%\rar.exe" x
set unpackZip="%pclBinPath%\unzip.exe" -o
set unpackZipNoClobber="%pclBinPath%\unzip.exe"

:: Scheduled Tasks Options
set taskCreate=schtasks /create /tn
set taskDelete=schtasks /delete /tn

:: Services Options
set svcCreate=sc create
set svcDelete=sc delete
set svcStop=net stop

:: WGET options to use

:: User Agents
:: Default User Agent
set userAgent=--user-agent="Mozilla/5.0 (Windows NT 5.1; rv:37.0) Gecko/20100101 Firefox/37.0"

:: Common User Agents
set userAgentBlank=--user-agent=""
set userAgentFirefox=--user-agent="Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0"
set userAgentIE=--user-agent="Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 5.1; en-US)"
set userAgentGoogleBot=--user-agent="Googlebot/2.1 (+http://www.googlebot.com/bot.html)"

:: Firefox User Agents
set userAgentFirefoxLinux=--user-agent="Mozilla/5.0 (X11; Linux i586; rv:31.0) Gecko/20100101 Firefox/31.0"
set userAgentFirefoxMac=--user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10; rv:33.0) Gecko/20100101 Firefox/33.0"
set userAgentFirefoxWindows=--user-agent="Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0"

:: IE User Agents
set userAgentIE11=--user-agent="Mozilla/5.0 (compatible, MSIE 11, Windows NT 6.3; Trident/7.0;  rv:11.0) like Gecko"
set userAgentIE10=--user-agent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)"
set userAgentIE9=--user-agent="Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.0; en-US)"
set userAgentIE8=--user-agent="Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 6.0; en-US)"
set userAgentIE7=--user-agent="Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 5.1; en-US)"
set userAgentIE6=--user-agent="Mozilla/5.0 (compatible; MSIE 6.0; Windows NT 5.1; en-US)"
set userAgentIE5=--user-agent="Mozilla/4.0 (compatible; MSIE 5.0; Windows 98)"
set userAgentIE4=--user-agent="Mozilla/4.0 (compatible; MSIE 4.0; Windows 98)"
set userAgentIE3=--user-agent="Mozilla/4.0 (compatible; MSIE 3.0; Windows 95)"
set userAgentIE2=--user-agent="Mozilla/4.0 (compatible; MSIE 2.0; Windows 95)"

:: Headers
:: Default Header
set header=--header="Accept: text/html"

:: Common Headers
set headerAccept=--header="Accept: text/html"
set headerHTML=--header="Accept: text/html"
set headerEXE=--header="application/octet-stream"
set headerZIP=--header="application/x-zip-compressed"

:: Display Text as Notepad or Notepad++
set defaultTextViewer=notepad
set showText=start "" "%windir%\notepad.exe"
set showTextPlus=start "" "%pclBinPath%\npp.exe"
set showTextWait="%windir%\notepad.exe"
set showTextPlusWait="%pclBinPath%\npp.exe"

:: File Commands

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

:: Registry Commands
set reg=reg
set regForce=reg /f
set regForceAdd=reg add /f
set regAdd=reg add
set regForceDelete=reg delete /f
set regDelete=reg delete
set regQuery=reg query /f
::set regQuery="%windir%\System32\reg.exe" query

set regImportFromFile=regedit /s

:: UAC Related
:: Cannot use PIPE in variable??
::set regQueryUacStatusVista="%windir%\System32\reg.exe" query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA | find "0x0"
set regQueryUacStatusVista="%windir%\System32\reg.exe" query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA
set regQueryUacStatusWin7=%regQueryUacStatusVista%
set regQueryUacStatusWin8="%windir%\System32\reg.exe" query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin
set regQueryUacStatusWin81=%regQueryUacStatusWin8%
set regQueryUacStatusWin10=%regQueryUacStatusWin8%

:: Default Run As Administrator
set runAsAdministrator=runas /user:administrator

:: Shutdown Commands
set execFileShutdownPowerDown="%windir%\system32\shutdown.exe" -s -t 0
set execFileShutdownRestart="%windir%\system32\shutdown.exe" -r -t 0
::set execFileShutdownSafeModeNormal="%windir%\system32\shutdown.exe" -r -t 0
::set execFileShutdownSafeModeNetwork="%windir%\system32\shutdown.exe" -r -t 0
::set execFileShutdownSafeModeCommand="%windir%\system32\shutdown.exe" -r -t 0

:: External CMD Options
set runShellNoTerminateAndWait=cmd /k
set runShellNoTerminate=start cmd /k
set runShellWaitNoTerminate=start /wait cmd /k
set runShellTerminateAndWait=cmd /c
set runShellTerminate=start cmd /c
set runShellWaitTerminate=start /wait cmd /c

:: Setting pwn Commands
set pwnLeft=takeown /f
set pwnRight=/a /r
set pwnLeft2=icacls
set pwnRight2=/grant:r User:F /T


:: Other system commands
set ws=wscript //nologo

:: Update Extraction Finalizing
set finalizeUpdatesToExternalMedia=%runShellTerminate% "%standardWindowsTempPath%\update-pcl.cmd"

:: Commands and Custom References To Commands Start Here
:: ---------------------------------------------------------------------------------------


:: ---------------------------------------------------------------------------------------
:: Other Misc Stuff Start Here
:: ---------------------------------------------------------------------------------------

:: Printing Related
set printerSpoolerStop=net stop spooler
set printerSpoolerStart=net start spooler

set printerSpoolPathMain=%systemroot%\system32\spool
set printerSpoolPath=%systemroot%\system32\spool\PRINTERS
set printerSpoolPathWild=%systemroot%\system32\spool\PRINTERS\*

:: GUI Popup Stuff

:: Wait GUI Popup Messages using Wbusy
set busyPopup="%pclBinPath%\Wbusy.exe"
set busyPopupTitle="Portable Cleaning Lab"
set busyPopupMessage="The current operation may take several minutes. Please Be Patient...."
set busyPopupDefault=start "" %Wbusy% %busyPopupTitle% %busyPopupMessage% /marquee

:: Stop Wbusy
set busyPopupClose=%Wbusy% %busyPopupTitle% /stop

:: ---------------------------------------------------------------------------------------


:: ---------------------------------------------------------------------------------------
:: Registry Paths

set regHKCR=HKEY_CLASSES_ROOT
set regHKCU=HKEY_CURRENT_USER
set regHKLM=HKEY_LOCAL_MACHINE
set regHKU=HKEY_USERS
set regHKCC=HKEY_CURRENT_USER

:: ---------------------------------------------------------------------------------------


:: ---------------------------------------------------------------------------------------
:: Text and Messages

set msgRemoveTemp=Removing Temp Files....
set msgRepack=Repacking PCL Module. Please Be Patient....
set msgCopyModule=Copying PCL Module To Source Media. Please Be Patient....


set msgbox=%pclBinPath%\msgbox.exe

set msgAlphaBuild="CURRENTLY ONLY TESTED RUNNING FROM THE ROOT OF A FLASH DRIVE!!!!!! This will aid you in cleaning your computer and ridding it of malware, viruses, scareware, adware, and all known badware in general. Everything is in portable form and absolutely NO INSTALLATION IS REQUIRED! Most options work as intended. Things that do not work are marked with an asterix (*) on the menu. Although I have tested everything to the best of my ability, please be cautious when using any removal scripts and ALWAYS MAKE A BACKUP FIRST OF ANY IMPORTANT DATA TO EXTERNAL MEDIA BEFORE STARTING ANY CLEANING OPERATION! YOU HAVE BEEN WARNED! NOW GO GET RID OF ALL THAT ANNOYING CRAP!!!" "Portable Cleaning Lab Public Alpha - USE AT YOUR OWN RISK!"

set msgBetaBuild="CURRENTLY ONLY TESTED RUNNING FROM THE ROOT OF A FLASH DRIVE!!!!!! This will aid you in cleaning your computer and ridding it of malware, viruses, scareware, adware, and all known badware in general. Everything is in portable form and absolutely NO INSTALLATION IS REQUIRED! Most options work as intended. Things that do not work are marked with an asterix (*) on the menu. Although I have tested everything to the best of my ability, please be cautious when using any removal scripts and ALWAYS MAKE A BACKUP FIRST OF ANY IMPORTANT DATA TO EXTERNAL MEDIA BEFORE STARTING ANY CLEANING OPERATION! YOU HAVE BEEN WARNED! NOW GO GET RID OF ALL THAT ANNOYING CRAP!!!" "Portable Cleaning Lab Public Beta - USE AT YOUR OWN RISK!"

set msgRCBuild="CURRENTLY ONLY TESTED RUNNING FROM THE ROOT OF A FLASH DRIVE!!!!!! This will aid you in cleaning your computer and ridding it of malware, viruses, scareware, adware, and all known badware in general. Everything is in portable form and absolutely NO INSTALLATION IS REQUIRED! Most options work as intended. Things that do not work are marked with an asterix (*) on the menu. Although I have tested everything to the best of my ability, please be cautious when using any removal scripts and ALWAYS MAKE A BACKUP FIRST OF ANY IMPORTANT DATA TO EXTERNAL MEDIA BEFORE STARTING ANY CLEANING OPERATION! YOU HAVE BEEN WARNED! NOW GO GET RID OF ALL THAT ANNOYING CRAP!!!" "Portable Cleaning Lab Release Candidate - USE AT YOUR OWN RISK!"

set msgHelpMain="A MORE DETAILED HELP SECTION WILL BE AVAILABLE SOON!! \n\nThis will help explain the basics of how I personally use this thing. \n\nI usually start with OPTION 1, Manual Malware Removal. \nNext, from manual menu, I usually run OPTION 1 and dump the registry entries. \nThen I run a BROWSER KILL LOOP and a BADDIE KILL LOOP depending on how bad the system is. \nI then run an UNINSTALL LOOP to force uninstallers to execute for baddies. \nI usually run this a few times and then run a REMOVE DIRECTORY and REGISTRY LOOP to clean up any leftovers. \nI now use option 11 from Manual Removal Menu to run Purge scripts, clear IE settings, and other cleanup items. \nThen its on to CCleaner using main menu OPTION 6 then OPTION 4. \nI run the CLEAN option then REGISTRY CLEAN OPTION, then remove startup entries and uninstall baddies. \nI now run Cleanup! to remove temp files from ALL User Accounts. \nFrom there i run some malware scanners such as Malwarebytes, Bitdefender, and SuperAntiSpyware. \n\n\nThe final cleanup is up to you. By this point your system should be fairly clean. \n\nFeel free to use any of the available tools included to help clean your system further." "Portable Cleaning Lab Help Info"

:: ---------------------------------------------------------------------------------------



:: ---------------------------------------------------------------------------------------
:: Misc and Unsorted


set displayVersionInfoExternal="%windir%\notepad.exe" "%pclDataPath%\version.txt"
set displayKnownIssuesExternal="%windir%\notepad.exe" "%pclTextPath%\known-issues.txt"
set displayTodoListExternal="%windir%\notepad.exe" "%pclTextPath%\todo.txt"

:: ---------------------------------------------------------------------------------------

