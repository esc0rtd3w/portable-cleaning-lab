@echo off

title Known Baddie Uninstall Loop

color 0b

:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)



:: Enable MSI uninstall in safe mode
cls
echo Enabling MSI Installer....
echo.
echo.

::call "%~dp0enable-msi-uninstall-in-safe-mode.cmd"
::"%pclBinPath%\SafeMSI.exe"

if not defined safeModeState goto doWork
if %safeModeState%==inactive goto doWork
if %safeModeState%==minimal "%pclBinPath%\SafeMSI.exe"
if %safeModeState%==network "%pclBinPath%\SafeMSI.exe"
if %safeModeState%==alternateshell "%pclBinPath%\SafeMSI.exe"


:doWork

color 0b

cls
echo [EXE Mode]
echo.
echo.
echo Press ENTER to start new run....
echo.
echo.

set /p doshit=



setlocal ENABLEDELAYEDEXPANSION

:: Program Files
color 0b
set listPF=%~dp0lists\uninstallPF.txt
for /f "tokens=*" %%a in (%listPF%) do (
    set /a listPF=!listPF! + 1
    set var!listPF!=%%a
	echo "%pf%\%%a"
	"%pf%\%%a" /s
)

:: Program Files (x86)
color 0d
set listPF64=%~dp0lists\uninstallPF.txt
for /f "tokens=*" %%a in (%listPF64%) do (
    set /a listPF64=!listPF64! + 1
    set var!listPF64!=%%a
	echo "%pf64%\%%a"
	"%pf64%\%%a" /s
)

:: Common Files
color 0b
set listCF=%~dp0lists\uninstallCF.txt
for /f "tokens=*" %%a in (%listCF%) do (
    set /a listCF=!listCF! + 1
    set var!listCF!=%%a
	echo "%cf%\%%a"
	"%cf%\%%a" /s
)

:: Common Files (x86)
color 0d
set listCF64=%~dp0lists\uninstallCF.txt
for /f "tokens=*" %%a in (%listCF64%) do (
    set /a listCF64=!listCF64! + 1
    set var!listCF64!=%%a
	echo "%cf64%\%%a"
	"%cf64%\%%a" /s
)

:: ProgramData
color 0a
set listPD=%~dp0lists\uninstallPD.txt
for /f "tokens=*" %%a in (%listPD%) do (
    set /a listPD=!listPD! + 1
    set var!listPD!=%%a
	echo "%pd%\%%a"
	"%pd%\%%a" /s
)

:: AllUsers
color 0a
set listPD=%~dp0lists\uninstallPD.txt
for /f "tokens=*" %%a in (%listPD%) do (
    set /a listPD=!listPD! + 1
    set var!listPD!=%%a
	echo "%au%\%%a"
	"%au%\%%a" /s
)

:: AppData-Local
color 05
set listADL=%~dp0lists\uninstallADL.txt
for /f "tokens=*" %%a in (%listADL%) do (
    set /a listADL=!listADL! + 1
    set var!listADL!=%%a
	echo "%adl%\%%a"
	"%adl%\%%a" /s
)

:: AppData-LocalLow
color 04
set listADLL=%~dp0lists\uninstallADLL.txt
for /f "tokens=*" %%a in (%listADLL%) do (
    set /a listADLL=!listADLL! + 1
    set var!listADLL!=%%a
	echo "%adll%\%%a"
	"%adll%\%%a" /s
)

:: AppData-Roaming
color 03
set listADR=%~dp0lists\uninstallADR.txt
for /f "tokens=*" %%a in (%listADR%) do (
    set /a listADR=!listADR! + 1
    set var!listADR!=%%a
	echo "%adr%\%%a"
	"%adr%\%%a" /s
)



:askpup
color 0a

set removePUP=n

cls
echo Uninstall Potentially Unwanted Programs (PUP)? [Y/N]:
echo.
echo Typer Y or N and press ENTER
echo.
echo.
echo HINT: Default is NO by just pressing ENTER
echo.
echo.

set /p removePUP=

if %removePUP%==N goto askoem
if %removePUP%==n goto askoem

:: Other PUP
color 02
set listPUP=%~dp0lists\uninstallPUP.txt
for /f "tokens=*" %%a in (%listPUP%) do (
    set /a listPUP=!listPUP! + 1
    set var!listPUP!=%%a
	echo "%pf%\%%a"
	"%pf%\%%a" /q
	"%pf%\%%a" /quiet
	"%pf%\%%a" /s
	"%pf%\%%a" /silent
	"%pf%\%%a" /uninstall
	"%pf%\%%a" /x
	"%pf%\%%a"
	echo "%pf64%\%%a"
	"%pf64%\%%a" /q
	"%pf64%\%%a" /quiet
	"%pf64%\%%a" /s
	"%pf64%\%%a" /silent
	"%pf64%\%%a" /uninstall
	"%pf64%\%%a" /x
	"%pf64%\%%a"
	echo "%pd%\%%a"
	"%pd%\%%a" /q
	"%pd%\%%a" /quiet
	"%pd%\%%a" /s
	"%pd%\%%a" /silent
	"%pd%\%%a" /uninstall
	"%pd%\%%a" /x
	"%pd%\%%a"
)



:askoem
color 0d

set removeOEM=n

cls
echo Uninstall OEM Crapware? [Y/N]:
echo.
echo Typer Y or N and press ENTER
echo.
echo.
echo HINT: Default is NO by just pressing ENTER
echo.
echo.

set /p removeOEM=

if %removeOEM%==N goto loopdone
if %removeOEM%==n goto loopdone

:: OEM Crapware
cls
color 01
set listOEM=%~dp0lists\uninstallOEM.txt
for /f "tokens=* delims=\" %%a in (%listOEM%) do (
    set /a listOEM=!listOEM! + 1
    set var!listOEM!=%%a
	echo "%pf%\%%a"
	"%pf%\%%a" /q
	"%pf%\%%a" /quiet
	"%pf%\%%a" /s
	"%pf%\%%a" /silent
	"%pf%\%%a" /uninstall
	"%pf%\%%a" /x
	"%pf%\%%a"
	echo "%pf64%\%%a"
	"%pf64%\%%a" /q
	"%pf64%\%%a" /quiet
	"%pf64%\%%a" /s
	"%pf64%\%%a" /silent
	"%pf64%\%%a" /uninstall
	"%pf64%\%%a" /x
	"%pf64%\%%a"
	echo "%pd%\%%a"
	"%pd%\%%a" /q
	"%pd%\%%a" /quiet
	"%pd%\%%a" /s
	"%pd%\%%a" /silent
	"%pd%\%%a" /uninstall
	"%pd%\%%a" /x
	"%pd%\%%a"
)


:loopdone

endlocal


goto dowork


:end





