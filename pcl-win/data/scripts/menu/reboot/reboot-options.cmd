@echo off

set titleText=Reboot and Shutdown Power Options :: portablecleaninglab.com
title %titleText%

set msg=A Shutdown Operation Has Been Initiated By Portable Cleaning Lab. You Can Abort This Action Within The Next 15 Seconds By Using Option 9 On Reboot Menu.



:menuMain
title %titleText%

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Select a reboot option from below and press ENTER:
echo.
echo.
echo 1) Normal
echo.
echo 2) Safe Mode*
echo.
echo 3) Safe Mode With Networking*
echo.
echo 4) Safe Mode With Command Prompt*
echo.
echo 5) Restart Windows Explorer Shell
echo.
echo 6) Restart Windows Explorer Shell as SYSTEM
echo.
echo 7) Log Off Current User
echo.
echo 8) Shut Down Computer (Hibernate)
echo.
echo 9) Shut Down Computer (Power Off)
echo.
echo A) Abort Current Shutdown Operation
echo.
echo.
echo B) Go Back
echo.
echo.

set /p menuItem=

if [%menuItem%]==[] goto menuMain

if %menuItem%==A goto optionA
if %menuItem%==a goto optionA

if %menuItem%==B goto end
if %menuItem%==b goto end

if %menuItem% gtr 9 goto menuMain

if %menuItem%==1 goto option1
if %menuItem%==2 goto option2
if %menuItem%==3 goto option3
if %menuItem%==4 goto option4
if %menuItem%==5 goto option5
if %menuItem%==6 goto option6
if %menuItem%==7 goto option7
if %menuItem%==8 goto option8
if %menuItem%==9 goto option9

goto menuMain



:option1

"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%

goto menuMain


:option2

if %ostype%==xp do (
bootcfg /raw /a /safeboot:minimal /id 1
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bootcfg /raw /fastdetect /id 1"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==vista do (
bcdedit /set {current} safeboot minimal
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==win7 do (
bcdedit /set {current} safeboot minimal
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==win8 do (
bcdedit /set {current} safeboot minimal
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==win81 do (
bcdedit /set {current} safeboot minimal
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


goto menuMain


:option3

if %ostype%==xp do (
bootcfg /raw /a /safeboot:network /id 1
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bootcfg /raw /fastdetect /id 1"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==vista do (
bcdedit /set {current} safeboot network
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==win7 do (
bcdedit /set {current} safeboot network
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==win8 do (
bcdedit /set {current} safeboot network
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==win81 do (
bcdedit /set {current} safeboot network
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


goto menuMain


:option4

if %ostype%==xp do (
bootcfg /raw /a /safeboot:minimal(alternateshell) /id 1
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bootcfg /raw /fastdetect /id 1"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==vista do (
bcdedit /set {current} safeboot minimal(alternateshell)
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==win7 do (
bcdedit /set {current} safeboot minimal(alternateshell)
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==win8 do (
bcdedit /set {current} safeboot minimal(alternateshell)
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)


if %ostype%==win81 do (
bcdedit /set {current} safeboot minimal(alternateshell)
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v "*UndoSB" /t REG_SZ /d "bcdedit /deletevalue {current} safeboot"
"%windir%\system32\shutdown.exe" -r -t 15 /c "%msg%
)

goto menuMain


:option5


taskkill /f /im explorer.exe
taskkill /f /t /im explorer.exe
start "" "%windir%\explorer.exe"

goto menuMain


:option6


taskkill /f /im explorer.exe
taskkill /f /t /im explorer.exe
%psexecElevateToSystem% %windir%\explorer.exe

goto menuMain


:option7

::"%windir%\system32\shutdown.exe" -l -t 10 /c "%msg%
"%windir%\system32\shutdown.exe" -l

goto menuMain


:option8

"%windir%\system32\shutdown.exe" -h -t 10 /c "%msg%

goto menuMain


:option9

if %windir%==X:\windows %SystemRoot%\system32\wpeutil.exe shutdown

::if %target_root%==C:\windows %SystemRoot%\system32\wpeutil.exe shutdown

"%windir%\system32\shutdown.exe" -s -t 10 /c "%msg%

goto menuMain


:optionA

"%windir%\system32\shutdown.exe" -a

goto menuMain


:end


