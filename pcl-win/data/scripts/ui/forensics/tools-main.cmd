@echo off

:reset

::%checkNetworkStatus%

:: Check exitStatus before continuing
if %exitStatus%==back (
goto end
)
if %exitStatus%==close (
goto end
)

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set manualMenuMode=forensics

set uiMode=forensics
color 0e

set titleText=Forensics Mode :: Tools :: portablecleaninglab.com
set bannerText=[OS: %ostype%/%bits%] [Safe Mode: %safeModeState%] [Network: %networkStatus%] [Mode: %uiMode%]

%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
echo.
%cocolor% 0b
echo 1) EXEInfoPE (EXE Analyzer)
echo.
echo 2) OllyDBG Disassembler/Debugger
echo.
echo 3) x64dbg (Open Source 32/64 Bit Debugger)
echo.
echo 4) XVI32 Hex Editor
echo.
echo 5) YARA Malware Analysis Tool
echo.
echo.
%cocolor% 0e
echo B) Go Back
echo.
echo X) Exit This Window
echo.

set /p menuItem=

if [%menuItem%]==[] goto reset

if %menuItem%==B goto chkExit
if %menuItem%==b goto chkExit

if %menuItem%==X goto chkExit
if %menuItem%==x goto chkExit

:: Fix for keyword returning back to main menu 20141117
:: If actually using the "menu" keyword then really do go back to main menu
:: Sets exitStatus as "menu" and goes to end of script, which returns to main PCL script 20141128
if %menuItem%==menu (
set exitStatus=ui
goto end
)
:: Use the init menuItem to return to the very beginning of the main PCL script
if %menuItem%==init (
set exitStatus=init
goto end
)
:: Use the reset menuItem to return to the reset label of the main PCL script
if %menuItem%==reset (
set exitStatus=reset
goto end
)

if %menuItem% gtr 5 goto reset

if %menuItem%==1 set moduleActive=exeinfope
if %menuItem%==2 set moduleActive=ollydbg
if %menuItem%==3 set moduleActive=x64dbg
if %menuItem%==4 set moduleActive=xvi32
if %menuItem%==5 set moduleActive=yara

set runDirectory=%pclTempMain%\%moduleActive%

goto runModule


:runModule
cls
echo Unpacking %moduleActive% module....
echo.
echo.

if exist "%pclTempMain%" %rmdir% "%pclTempMain%"
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

%pclExtractModule% "%pclModulesPath%\forensics\%moduleActive%.pcl" "%pclTempMain%"
call "%pclMenuPath%\forensics\fixes.cmd"
%runShellTerminateAndWait% "%runDirectory%\launch.cmd"

goto reset


:chkExit

if %menuItem%==B set exitStatus=ui
if %menuItem%==b set exitStatus=ui

if %menuItem%==X set exitStatus=close
if %menuItem%==x set exitStatus=close

:: If an exitStatus is not set then set it to return as default
::if not defined exitStatus set exitStatus=return

if %exitStatus%==return goto reset

goto end


:end

