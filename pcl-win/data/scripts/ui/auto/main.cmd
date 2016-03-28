@echo off

:reset

:: GUI USE ONLY
if exist "%windir%\temp\initGUI.txt" (
call "..\..\core\get-drive-root.cmd"
call "..\..\core\set-global.cmd"
)

%checkNetworkStatus%

:: Recheck next available drive letter (added 20141201)
:: Solves issues when devices are connected after initial launch
%getNextAvailableDriveLetter%
%setNextAvailableDriveLetter%

set titleText=Portable Cleaning Lab v%mainVer% Auto Mode :: portablecleaninglab.com
title %titleText%

set uiMode=auto
set bannerText=[OS: %ostype%/%bits%] [Safe Mode: %safeModeState%] [Network: %networkStatus%] [Mode: %uiMode%]


cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Cleaning Known Temp Folders....
echo.
echo The next step will automatically be loaded!
echo.

"%pclBinPath%\ccleaner.exe" /auto

:: Normal Temp Folder
if "%temp1%\*"=="\*" goto skipClean
for /d %%a in (%temp1%\*) do %rmdir% "%%a"
%rmsub% "%temp1%\*"

:: C:\Temp Folder
if "%temp2%\*"=="\*" goto skipClean
for /d %%b in (%temp2%\*) do %rmdir% "%%b"
%rmsub% "%temp2%\*"

:: C:\Windows\Temp Folder
if "%temp3%\*"=="\*" goto skipClean
for /d %%b in (%temp3%\*) do %rmdir% "%%b"
%rmsub% "%temp3%\*"

:: C:\Windows\System32\config\systemprofile\AppData\Local\Temp Folder
if "%temp4%\*"=="\*" goto skipClean
if exist "%temp4%" for /d %%c in (%temp4%\*) do %rmdir% "%%c"
if exist "%temp4%" %rmsub% "%temp4%\*"

:skipClean
::set
::pause
cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Cleaning Known Temp Folders....
echo.
echo The next step will automatically be loaded!
echo.

%wait% 5

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Cleaning Notification Area Icons....
echo.
echo The next step will automatically be loaded!
echo.

%runShellNoTerminate% "%pclScriptsPath%\purge-notification-cache.cmd"

%wait% 5

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Dumping Known Malware Locations From The Registry....
echo.
echo The next step will automatically be loaded!
echo.
%regImportFromFile% "%pclRegistryPath%\fixes\multi-malware-reg-fix.reg"
%runShellNoTerminate% "%pclScriptsPath%\dump-all-locations-auto.cmd"

%wait% 20

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Running a Browser Kill Loop....
echo.
echo The next step will automatically be loaded!
echo.
%runShellNoTerminate% "%pclScriptsPath%\browser-loop-auto.cmd"

%wait% 10

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Running a Baddie Services Removal Loop....
echo.
echo The next step will automatically be loaded!
echo.
%runShellNoTerminate% "%pclScriptsPath%\services-loop-auto.cmd"

%wait% 10

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Running a Baddie Tasks Removal Loop....
echo.
echo The next step will automatically be loaded!
echo.
%runShellNoTerminate% "%pclScriptsPath%\tasks-loop-auto.cmd"

%wait% 10

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Running a Known Malware Process Kill Loop....
echo.
echo The next step will automatically be loaded!
echo.
%runShellNoTerminate% "%pclScriptsPath%\tkloop-auto.cmd"

%wait% 10

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Running a Known Malware Uninstall One-Time Loop....
echo.
echo The next step will automatically be loaded!
echo.
echo YOU WILL HAVE TO CLICK YES AND UNINSTALL ANYTHING THAT POPS UP
echo.
%runShellNoTerminate% "%pclScriptsPath%\uninstall-loop-auto.cmd"

%wait% 60

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Running a Known Malware MSI Uninstall One-Time Loop....
echo.
echo The next step will automatically be loaded!
echo.
echo YOU WILL HAVE TO CLICK YES AND UNINSTALL ANYTHING THAT POPS UP
echo.
%runShellNoTerminate% "%pclScriptsPath%\uninstall-loop-msi-auto.cmd"

%wait% 60

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Running a Known Malware Registry Removal One-Time Loop....
echo.
echo The next step will automatically be loaded!
echo.
%runShellNoTerminate% "%pclScriptsPath%\reg-loop-auto.cmd"

%wait% 10

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Running a Known Malware File/Folder Removal One-Time Loop....
echo.
echo The next step will automatically be loaded!
echo.
%runShellNoTerminate% "%pclScriptsPath%\rmloop-auto.cmd"


%wait% 90


:: Misc Fixes Before Running Scanners
%regImportFromFile% "%pclRegistryPath%\enable-task-manager.reg"


:: Modules Auto Loader Begin

::-START MODULE-----------------------------------------------------------------------
set moduleActive=mcafee-stinger
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=antivir
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=bitdefender
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=eset
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=trend-micro
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=mcafee-virus-scan
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=vba32
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=fprot
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=comodo
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=emsisoft
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=sophos
set moduleType=cleaning
set moduleSubType=scanners
set moduleSubTypeLayers=2
set supressModuleLaunch=0
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%
::-END MODULE-------------------------------------------------------------------------


::-START MODULE-----------------------------------------------------------------------
set moduleActive=wincontig
set moduleType=maintenance
set moduleSubTypeLayers=1
set supressModuleLaunch=1
%bannerMenuDefault%
%unpackActiveModule%
%runActiveModuleAuto%

call "%runDirectory%\auto.cmd"
%wait% 10
::-END MODULE-------------------------------------------------------------------------


%runShellNoTerminate% "%pclScriptsPath%\sfc-scan.cmd"


:end

