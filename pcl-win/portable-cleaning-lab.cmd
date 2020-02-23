@echo off

:init

:: Change terminal size
mode con lines=41

color 0e

:: ---------------------------------------------------------------------------------
:: THIS MUST BE THE FIRST SECTION OF COMMANDS EXECUTED FOR GLOBAL VARIABLES TO WORK
:: ---------------------------------------------------------------------------------

:: Setting default root PCL path (E:\pcl-win\) (USES A BACKSLASH AT THE END)
set root=%~dp0

:: Executing scripting to get drive root info relative to where main PCL script launches
call "%root%data\scripts\core\get-drive-root.cmd"

:: Set target drive (default c: or x: if PE)
call "%root%data\scripts\core\set-target-drive.cmd"

:: Setting default variables for system check preparation
if not exist "%windir%\Temp\pcl\rootDrive.id" (
set systemActive=0
set tempGlobal=%temp%
echo %UserName%>"%windir%\temp\currentLocalUser.id"
echo %UserProfile%>"%windir%\temp\currentLocalUserProfile.id"
echo %LocalAppData%>"%windir%\temp\currentADL.id"
)

:: Checking if the PCL was invoked as SYSTEM
if exist "%windir%\Temp\pcl\rootDrive.id" (
set systemActive=1
set /p currentLocalUser=<"%windir%\temp\currentLocalUser.id"
set /p currentLocalUserProfile=<"%windir%\temp\currentLocalUserProfile.id"
set /p currentADL=<"%windir%\temp\currentADL.id"
set tempGlobal=%currentADL%\Temp
if not exist "%tempGlobal%\pcl" md "%tempGlobal%\pcl"
copy /y "%windir%\Temp\pcl\rootDrive.id" "%tempGlobal%\pcl"
del /f /q "%windir%\Temp\pcl\rootDrive.id"
)

::echo currentLocalUser: %currentLocalUser%
::echo currentLocalUserProfile: %currentLocalUserProfile%
::echo currentADL: %currentADL%
::echo tempGlobal: %tempGlobal%
::pause

:: Check for PE Mode
::%checkForPeMode%
::if exist "%pclTempMain%\pemode.state" set /p peModeState=<"%pclTempMain%\pemode.state"
set | find "target_root"
if %errorlevel%==1 set peModeState=disabled
if %errorlevel%==0 set peModeState=enabled

:: Set module path override if PE Mode
if %peModeState%==enabled (
set overrideModulePaths=1
)

:: Set global variables and commands
set setGlobalVariables=call "%root%data\scripts\core\set-global.cmd"
if %systemActive%==0 %setGlobalVariables%

:: Set global variables if SYSTEM detected and PE MODE active
if %systemActive%==1 (
	if %peModeState%==enabled (
	%setGlobalVariables%
	)
)


:: Check INI Files
cls
echo %messagePreparingToLoad%
%checkIniFiles%

:: Create default directory structure for temp use
cls
echo %messagePreparingToLoad%
%createLocalTempDirectoryStructure%

:: Check Windows UAC
cls
if %peModeState%==disabled (
echo %messagePreparingToLoad%
%checkUAC%
)

:: ---------------------------------------------------------------------------------

:: ---------------------------------------------------------------------------------
:: THIS SECTION IS FOR DECIDING IF THE PCL IS INVOKED AS USER OR SYSTEM
:: ---------------------------------------------------------------------------------

:: Dump current environment if USER
if %systemActive%==0 set>%pclCurrentEnvironment%

:: Set current environment from USER if SYSTEM
if %systemActive%==1 %pclCurrentEnvironmentReadToBatch%

:: Auto select SYSTEM if a pclLaunchMode is not set
:: This can only happen if the PCL was invoked to run as SYSTEM
if not defined pclLaunchMode set pclLaunchMode=system

:: Check for relaunch of PCL as SYSTEM
:: This step creates the systemInit.cmd file
:: THE BELOW CODE CAUSES SYSTEM TO LOOP ONCE INITIATED!!! FIX IT!!!
if %pclLaunchMode%==system (
%pclCurrentEnvironmentReadToBatch%
%psexecElevateToSystem% "%pclRootPath%\portable-cleaning-lab.cmd"
exit
)

:: If USER then set pclmode as user and move on
if %pclLaunchMode%==user (
echo user>"%pclTempMain%\pcl.mode"
set /p pclMode=<"%pclTempMain%\pcl.mode"
)

:: ----------------------------------------------------------------------


:: ----------------------------------------------------------------------
:: AT THIS POINT ALL GLOBAL VARIABLES SHOULD BE SET AND USED. USE THEM!!
:: ----------------------------------------------------------------------

:: Jump here if files need pre-cleaned but global variables do not need reset
:preclean
cls
echo %messagePreparingToLoad%
echo.

%preCleanAllFiles%

:: Create default structure
%mkdir% "%pclTempMain%"
%mkdir% "%pclTempTemp%"


:reset
:: This is the MAIN RESET point to jump to
:: This does not re-initiate global variables or pre-clean files
:: Use "init" to jump to if you need to re-initialize global variables and pre-clean files

:: Get local config from PCL INI files
%getLocalConfig%

:: Set default dump path to AllUsers Profile (ProgramData)
echo %AllUsersProfile%\pcl\dumps>%dumpPathCheckFile%
::set /p pclDumpPathLocal=<%dumpPathCheckFile%

cls
echo %messagePreparingToLoad%
echo.
:: Change terminal size
mode con lines=41

:: Added 20101010 - Fixes windows 10 write issues to root C:\ drive
:: Set temp PCL module build path to the next available drive letter
%getNextAvailableDriveLetter%
%setNextAvailableDriveLetter%

:: Kill lingering processes
%killTheLingering%

:: Display titleText and show loading message
title %titleText%
cls
echo %messagePreparingToLoad%
echo.

:: Show Pre-Release message toggle
::if %msgNoShow%==0 %msgbox% %msgAlphaBuild%
::if %msgNoShow%==0 %msgbox% %msgBetaBuild%
if %msgNoShow%==0 %msgbox% %msgRCBuild%

:: Check for Safe Mode
%checkForSafeMode%
if exist "%pclTempMain%\safemode.state" set /p safeModeState=<"%pclTempMain%\safemode.state"

:: Check for PE Mode
::%checkForPeMode%
::if exist "%pclTempMain%\pemode.state" set /p peModeState=<"%pclTempMain%\pemode.state"

:: Check network status and create detectme files before starting
%checkNetworkStatus%

:: Check file access permissions (added 20141115)
%checkFileAccess%

:: This sets UI defaults and MUST ALWAYS be above the checkUI label
%setUiModeDefault%


:: Check/Change UI Mode
:checkUI

%checkUiMode%

:: Auto Check for updates on launch (added 20141115)
:: Now controlled by INI file (added 20141201)
if %disableUpdatesAuto%==0 set initUpdate=1
if %disableUpdatesAuto%==0 %checkForUpdates%

:: If the menu is the ui.mode then launch the ui menu
if %uiModeOverride%==menu %switchUiMode%


:menuMain
:: Get Paths for default dump path script
if not exist "%pclDumpPathLocal%" %mkdir% "%pclDumpPathLocal%"
if not exist "%pclModuleTempPath%" %mkdir% "%pclModuleTempPath%"

:: Set UI Mode to keep banner accurate
%setUiMode%

:: Check ui override variable to see where to go
if %uiModeOverride%==auto goto modeAuto
if %uiModeOverride%==easy goto modeEasy
if %uiModeOverride%==expert goto modeExpert
if %uiModeOverride%==forensics goto modeForensics

:: Check the UI Mode to display proper menu
if %uiMode%==auto goto modeAuto
if %uiMode%==easy goto modeEasy
if %uiMode%==expert goto modeExpert
if %uiMode%==forensics goto modeForensics

:: Failsafe for uimode not matching expected input
goto end


:modeExpert
if %exitStatus%==return (
if exist "%pclTempMain%\uiMode.state" set /p uiMode=<"%pclTempMain%\uiMode.state"
if exist "%pclTempMain%\uiModeOverride.state" set /p uiMode=<"%pclTempMain%\uiModeOverride.state"
%uiModeExpert%
)

if %exitStatus%==menu (
set exitStatus=return
goto menuMain
)

if %exitStatus%==ui (
set exitStatus=return
goto checkUI
)

if %exitStatus%==init (
set exitStatus=return
goto init
)

if %exitStatus%==reset (
set exitStatus=return
goto reset
)

if %exitStatus%==close (
goto end
)

:: Default failsafe if exitStatus is set to "return"
:: It will fall here and get reset to "return" again
set exitStatus=return
goto menuMain


:modeForensics
if %exitStatus%==return (
if exist "%pclTempMain%\uiMode.state" set /p uiMode=<"%pclTempMain%\uiMode.state"
if exist "%pclTempMain%\uiModeOverride.state" set /p uiMode=<"%pclTempMain%\uiModeOverride.state"
%uiModeForensics%
)

if %exitStatus%==menu (
set exitStatus=return
goto menuMain
)

if %exitStatus%==ui (
set exitStatus=return
goto checkUI
)

if %exitStatus%==init (
set exitStatus=return
goto init
)

if %exitStatus%==reset (
set exitStatus=return
goto reset
)

if %exitStatus%==close (
goto end
)

:: Default failsafe if exitStatus is set to "return"
:: It will fall here and get reset to "return" again
set exitStatus=return

goto menuMain


:modeAuto

%uiModeAuto%

goto checkUI


:modeEasy
if %exitStatus%==return (
if exist "%pclTempMain%\uiMode.state" set /p uiMode=<"%pclTempMain%\uiMode.state"
if exist "%pclTempMain%\uiModeOverride.state" set /p uiMode=<"%pclTempMain%\uiModeOverride.state"
%uiModeEasy%
)

if %exitStatus%==menu (
set exitStatus=return
goto menuMain
)

if %exitStatus%==ui (
set exitStatus=return
goto checkUI
)

if %exitStatus%==init (
set exitStatus=return
goto init
)

if %exitStatus%==reset (
set exitStatus=return
goto reset
)

if %exitStatus%==close (
goto end
)

:: Default failsafe if exitStatus is set to "return"
:: It will fall here and get reset to "return" again
set exitStatus=return

goto menuMain


:tempPathFix

cls
echo HALT! SYSTEM SCREWED UP THE TEMP PATH!!!
echo.
pause

goto end


:end

:: Removing "Take Ownership" from context menu
%regImportFromFile% "%pclRegistryPath%\remove-take-ownership.reg"

:: Cleaning log files
%postCleanAllFiles%

exit
