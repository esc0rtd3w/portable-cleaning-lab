@echo off

color 0b


:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)


:: Setting pwn commands
set pwnLeft=takeown /f
set pwnRight=/a /r


:doWork

color 0b

cls



setlocal ENABLEDELAYEDEXPANSION

:: Program Files
color 0b
set listPF=%~dp0lists\uninstallPF.txt
for /f "tokens=1 delims=\" %%a in (%listPF%) do (
    set /a listPF=!listPF! + 1
    set var!listPF!=%%a
	echo "%pf%\%%a"
	%rm% "%pf%\%%a"
)

:: Program Files (x86)
color 0d
set listPF64=%~dp0lists\uninstallPF.txt
for /f "tokens=1 delims=\" %%a in (%listPF64%) do (
    set /a listPF64=!listPF64! + 1
    set var!listPF64!=%%a
	echo "%pf64%\%%a"
	%rm% "%pf64%\%%a"
)

:: Common Files
color 0b
set listCF=%~dp0lists\uninstallCF.txt
for /f "tokens=1 delims=\" %%a in (%listCF%) do (
    set /a listCF=!listCF! + 1
    set var!listCF!=%%a
	echo "%cf%\%%a"
	%rm% "%cf%\%%a"
)

:: Common Files (x86)
color 0d
set listCF64=%~dp0lists\uninstallCF.txt
for /f "tokens=1 delims=\" %%a in (%listCF64%) do (
    set /a listCF64=!listCF64! + 1
    set var!listCF64!=%%a
	echo "%cf64%\%%a"
	%rm% "%cf64%\%%a"
)

:: ProgramData
color 0a
set listPD=%~dp0lists\uninstallPD.txt
for /f "tokens=1 delims=\" %%a in (%listPD%) do (
    set /a listPD=!listPD! + 1
    set var!listPD!=%%a
	echo "%pd%\%%a"
	%rm% "%pd%\%%a"
)

:: AppData-Local
color 05
set listADL=%~dp0lists\uninstallADL.txt
for /f "tokens=1 delims=\" %%a in (%listADL%) do (
    set /a listADL=!listADL! + 1
    set var!listADL!=%%a
	echo "%adl%\%%a"
	%rm% "%adl%\%%a"
)

:: AppData-LocalLow
color 04
set listADLL=%~dp0lists\uninstallADLL.txt
for /f "tokens=1 delims=\" %%a in (%listADLL%) do (
    set /a listADLL=!listADLL! + 1
    set var!listADLL!=%%a
	echo "%adll%\%%a"
	%rm% "%adll%\%%a"
)

:: AppData-Roaming
color 03
set listADR=%~dp0lists\uninstallADR.txt
for /f "tokens=1 delims=\" %%a in (%listADR%) do (
    set /a listADR=!listADR! + 1
    set var!listADR!=%%a
	echo "%adr%\%%a"
	%rm% "%adr%\%%a"
)

:: Other PUP
color 02
set listPUP=%~dp0lists\uninstallPUP.txt
for /f "tokens=1 delims=\" %%a in (%listPUP%) do (
    set /a listPUP=!listPUP! + 1
    set var!listPUP!=%%a
	echo "%pf%\%%a"
	%rm% "%pf%\%%a"
)

:: Leftover rmList
color 01
set rmList=%~dp0lists\rmList.txt
for /f "tokens=* delims=\" %%a in (%rmList%) do (
    set /a rmList=!rmList! + 1
    set var!rmList!=%%a
	echo "%pd%\%%a"
	%rm% "%pd%\%%a"
	echo "%adl%\%%a"
	%rm% "%adl%\%%a"
	echo "%adll%\%%a"
	%rm% "%adll%\%%a"
	echo "%adr%\%%a"
	%rm% "%adr%\%%a"
	echo "%cf%\%%a"
	%rm% "%cf%\%%a"
	echo "%cf64%\%%a"
	%rm% "%cf64%\%%a"
	echo "%pf%\%%a"
	%rm% "%pf%\%%a"
	echo "%pf64%\%%a"
	%rm% "%pf64%\%%a"
)



:askpup
color 0a

set removePUP=n

cls
echo Remove Potentially Unwanted Programs (PUP)? [Y/N]:
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

:: Leftover rmPUP
color 01
set rmPUP=%~dp0lists\rmPUP.txt
for /f "tokens=* delims=\" %%a in (%rmPUP%) do (
    set /a rmPUP=!rmPUP! + 1
    set var!rmPUP!=%%a
	echo "%pd%\%%a"
	%rm% "%pd%\%%a"
	echo "%adl%\%%a"
	%rm% "%adl%\%%a"
	echo "%adll%\%%a"
	%rm% "%adll%\%%a"
	echo "%adr%\%%a"
	%rm% "%adr%\%%a"
	echo "%cf%\%%a"
	%rm% "%cf%\%%a"
	echo "%cf64%\%%a"
	%rm% "%cf64%\%%a"
	echo "%pf%\%%a"
	%rm% "%pf%\%%a"
	echo "%pf64%\%%a"
	%rm% "%pf64%\%%a"
)


:askoem
color 0d

set removeOEM=n

cls
echo Remove OEM Crapware? [Y/N]:
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
set listOEM=%~dp0lists\rmOEM.txt
for /f "tokens=1 delims=\" %%a in (%listOEM%) do (
    set /a listOEM=!listOEM! + 1
    set var!listOEM!=%%a
	echo "%pd%\%%a"
	%rm% "%pd%\%%a"
	echo "%adl%\%%a"
	%rm% "%adl%\%%a"
	echo "%adll%\%%a"
	%rm% "%adll%\%%a"
	echo "%adr%\%%a"
	%rm% "%adr%\%%a"
	echo "%cf%\%%a"
	%rm% "%cf%\%%a"
	echo "%cf64%\%%a"
	%rm% "%cf64%\%%a"
	echo "%pf%\%%a"
	%rm% "%pf%\%%a"
	echo "%pf64%\%%a"
	%rm% "%pf64%\%%a"
)


:loopdone

endlocal


goto dowork


:end





