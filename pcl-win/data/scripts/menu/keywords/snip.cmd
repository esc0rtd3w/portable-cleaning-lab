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
goto end
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

start "" %snippingTool%


:end

exit


