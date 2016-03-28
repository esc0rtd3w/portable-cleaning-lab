@echo off


:: ----------------------------------------------------------------------
:: pcl.ini 
:: ----------------------------------------------------------------------

:: Check remote "pcl.ini" file (Used for version compare in update script)
set iniFileCurrent="%pclTempUpdates%\%pclConfigFileMainRemote%"
set iniSectionCurrent=core
set iniItemCurrent=mainVer
%iniRead%
set pclRemoteVersion=%mainVer%

:: Check local "pcl.ini" file (Used for version compare in update script)
set iniFileCurrent="%pclRootPath%\%pclConfigFileMainLocal%"
set iniSectionCurrent=core
set iniItemCurrent=mainVer
%iniRead%
set pclLocalVersion=%mainVer%

:: Set mainVer to overwrite global variable
set iniFileCurrent="%pclRootPath%\%pclConfigFileMainLocal%"
set iniSectionCurrent=core
set iniItemCurrent=mainVer
%iniRead%
set mainVer=%mainVer%

:: Set pclLaunchMode to overwrite global variable
set iniFileCurrent="%pclRootPath%\%pclConfigFileMainLocal%"
set iniSectionCurrent=core
set iniItemCurrent=pclLaunchMode
%iniRead%
set pclLaunchMode=%pclLaunchMode%

:: Check remote "pcl.ini" file (Used for version compare in update script)
set iniSectionCurrent=modules
set iniItemCurrent=updateFailLimit
%iniRead%
set updateFailLimit=%updateFailLimit%

:: Override Flag for module paths from INI use
set iniSectionCurrent=modules
set iniItemCurrent=overrideModulePaths
%iniRead%
set overrideModulePaths=%overrideModulePaths%

:: Only change module path if override is set to 1
if %overrideModulePaths%==1 (
:: Check module paths main
set iniSectionCurrent=modules
set iniItemCurrent=pclModulesPath
%iniRead%
set pclModulesPath=%pclModulesPath%

:: Check module paths for cleaning scanners
set iniSectionCurrent=modules
set iniItemCurrent=pclModulesCleaningScannersPath
%iniRead%
set pclModulesCleaningScannersPath=%pclModulesCleaningScannersPath%
)

:: Show/Hide Pre-Release Messages
set iniSectionCurrent=options
set iniItemCurrent=msgNoShow
%iniRead%
set msgNoShow=%msgNoShow%

:: Enable/Disable Auto Mode
set iniSectionCurrent=options
set iniItemCurrent=disableAutoMode
%iniRead%
set disableAutoMode=%disableAutoMode%

:: Enable/Disable Easy Mode
set iniSectionCurrent=options
set iniItemCurrent=disableEasyMode
%iniRead%
set disableEasyMode=%disableEasyMode%

:: Enable/Disable Expert Mode
set iniSectionCurrent=options
set iniItemCurrent=disableExpertMode
%iniRead%
set disableExpertMode=%disableExpertMode%

:: Change Default Text Viewer
set iniSectionCurrent=options
set iniItemCurrent=defaultTextViewer
%iniRead%
set defaultTextViewer=%defaultTextViewer%

:: Enable/Disable Updates
set iniSectionCurrent=updates
set iniItemCurrent=disableUpdates
%iniRead%
set disableUpdates=%disableUpdates%

:: Enable/Disable Auto Updates
set iniSectionCurrent=updates
set iniItemCurrent=disableUpdatesAuto
%iniRead%
set disableUpdatesAuto=%disableUpdatesAuto%

:: MD5 Creation
set iniSectionCurrent=updates
set iniItemCurrent=md5CreateToggle
%iniRead%
set md5CreateToggle=%md5CreateToggle%

:: Change the update server URL
set iniSectionCurrent=updates
set iniItemCurrent=updateServer
%iniRead%
set updateServer=%updateServer%

:: Change the update path on server
set iniSectionCurrent=updates
set iniItemCurrent=remoteUpdatePath
%iniRead%
set remoteUpdatePath=%remoteUpdatePath%

:: Change the update list on server
set iniSectionCurrent=updates
set iniItemCurrent=updateListServer
%iniRead%
set updateListServer=%updateListServer%

:: Enable/Disable Debug Mode
set iniSectionCurrent=test
set iniItemCurrent=debugMode
%iniRead%
set debugMode=%debugMode%

:: Set options for checking Safe Mode
set iniSectionCurrent=test
set iniItemCurrent=safeModeCheck
%iniRead%
set safeModeCheck=%safeModeCheck%

:: Set options for checking PE Mode
set iniSectionCurrent=test
set iniItemCurrent=peModeCheck
%iniRead%
set peModeCheck=%peModeCheck%


:: ----------------------------------------------------------------------
:: something-else-here.ini 
:: ----------------------------------------------------------------------


:end

