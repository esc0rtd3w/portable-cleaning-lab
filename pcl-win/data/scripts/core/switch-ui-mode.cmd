@echo off

if not exist "%pclTempMain%\" md "%pclTempMain%\"

:: Temp fix until UI Mode change is stable (20140829)
::echo expert>"%pclTempMain%\uiMode.state"
::goto end


:menu
color 0e

::set titleText=Portable Cleaning Lab v%mainVer% Public Alpha :: portablecleaninglab.com
set titleText=Portable Cleaning Lab v%mainVer% %textReleaseType% :: portablecleaninglab.com
set bannerText=[OS: %ostype%/%bits%] [Safe Mode: %safeModeState%] [Network: %networkStatus%] [Mode: %uiMode%]
title %titleText%

set uiModeChange=1

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0f
echo.
echo.
echo Choose an Operating Mode and press ENTER:
echo.
%cocolor% 0a
echo.
echo.
echo 1) Automatic (Default)
echo.
echo    - THIS WILL RUN A FULLY AUTOMATIC CLEANING SESSION AND RETURN HERE
echo.
echo    - YOU WILL HAVE TO CLICK YES AND UNINSTALL ANYTHING THAT POPS UP :/ sorry
echo.
echo    - ANY BLACK WINDOWS LIKE THIS ONE THAT OPEN ARE SAFE TO CLOSE AT ANYTIME
echo.
echo.
%cocolor% 0b
echo 2) Easy
echo.
echo    - THIS MODE IS FOR THOSE WITH SOME EXPERIENCE IN NAVIGATING AND USAGE
echo.
echo.
%cocolor% 0e
echo 3) Expert
echo.
echo    - FOR THE MORE EXPERIENCED USER, THIS WILL PROVIDE YOU WITH TONS OF OPTIONS
echo.
echo.
%cocolor% 0d
echo 4) Forensics
echo.
echo    - THIS MODE IS FOR EXAMINING, CAPTURING, AND ANALYZING DATA
echo.
echo    - THERE ARE SCRIPTS AND TOOLS TO AID IN REVERSE ENGINEERING MALWARE
echo.
echo.
echo.
%cocolor% 0f
echo To choose Automatic Mode, simply press ENTER
%cocolor% 09
echo.
echo.
echo                                                                        [X] EXIT
echo.
%cocolor% 0f

set /p uiModeChange=

if %uiModeChange%==X exit
if %uiModeChange%==x exit

if %uiModeChange% gtr 4 goto menu

if %uiModeChange%==1 echo auto>"%pclTempMain%\uiMode.state"
if %uiModeChange%==2 echo easy>"%pclTempMain%\uiMode.state"
if %uiModeChange%==3 echo expert>"%pclTempMain%\uiMode.state"
if %uiModeChange%==4 echo forensics>"%pclTempMain%\uiMode.state"

if %uiModeChange%==1 echo auto>"%pclTempMain%\uiModeOverride.state"
if %uiModeChange%==2 echo easy>"%pclTempMain%\uiModeOverride.state"
if %uiModeChange%==3 echo expert>"%pclTempMain%\uiModeOverride.state"
if %uiModeChange%==4 echo forensics>"%pclTempMain%\uiModeOverride.state"


:end

