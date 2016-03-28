@echo off

:initMain
:: Check OS
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

:: Set variables based on OS Type
if %ostype%==xp (
set snippingTool="%windir%\system32\SnippingTool.exe"
set snippingToolBackup="%temp%\SnippingTool.exe.bak"
set helpPane="%windir%\HelpPane.exe"
set helpPaneBackup="%temp%\HelpPane.exe.bak"
)

if %ostype%==vista (
set snippingTool="%windir%\system32\SnippingTool.exe"
set snippingToolBackup="%temp%\SnippingTool.exe.bak"
set helpPane="%windir%\HelpPane.exe"
set helpPaneBackup="%temp%\HelpPane.exe.bak"
)

if %ostype%==win7 (
set snippingTool="%windir%\system32\SnippingTool.exe"
set snippingToolBackup="%temp%\SnippingTool.exe.bak"
set helpPane="%windir%\HelpPane.exe"
set helpPaneBackup="%temp%\HelpPane.exe.bak"
)

if %ostype%==win8 (
set snippingTool="%windir%\system32\SnippingTool.exe"
set snippingToolBackup="%temp%\SnippingTool.exe.bak"
set helpPane="%windir%\HelpPane.exe"
set helpPaneBackup="%temp%\HelpPane.exe.bak"
)

if %ostype%==win81 (
set snippingTool="%windir%\system32\SnippingTool.exe"
set snippingToolBackup="%temp%\SnippingTool.exe.bak"
set helpPane="%windir%\HelpPane.exe"
set helpPaneBackup="%temp%\HelpPane.exe.bak"
)

if %ostype%==win10 (
set snippingTool="%windir%\system32\SnippingTool.exe"
set snippingToolBackup="%temp%\SnippingTool.exe.bak"
set helpPane="%windir%\HelpPane.exe"
set helpPaneBackup="%temp%\HelpPane.exe.bak"
)

:: Setting pwn commands
set pwnLeft=takeown /f
set pwnRight=/a /r

cls
echo ATTN: This script is in testing and probably does not work!
echo.
echo YOU MAY PRESS ENTER TO CONTINUE OR CLOSE THIS WINDOW....
echo.
echo.

pause

goto check


:debug
:: Show current variables (debug only)
::cls
::echo snippingTool: %snippingTool%
::echo snippingToolBackup: %snippingToolBackup%
::echo helpPane: %helpPane%
::echo helpPaneBackup: %helpPaneBackup%
::pause

goto check


:check
:: Check of backups already exist
set threshold=0
if exist %snippingToolBackup% set /a threshold=%threshold%+1
if exist %helpPaneBackup% set /a threshold=%threshold%+1

if %threshold% gtr 0 goto patched

goto backup


:backup

:: Take ownership of HelpPane.exe
%pwnLeft% %helpPane% %pwnRight%

:: Make backups of original files only if backups do not exist
copy /y %helpPane% %helpPaneBackup%
copy /y %snippingToolBackup% %snippingToolBackup%

goto replace


:replace
:: Overwrite the HelpPane.exe file with the SnippingTool.exe file

copy /y %snippingTool% %helpPane%

pause

goto end


:patched
cls
echo Backup files exist already!
echo.
echo.
echo Do Something!!!
echo.
echo.
pause

goto end



:end

exit


