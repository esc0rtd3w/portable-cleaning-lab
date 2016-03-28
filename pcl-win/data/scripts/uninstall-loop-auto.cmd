@echo off

title Known Baddie Uninstall Loop

color 0b

:: GUI USE ONLY
if exist "%windir%\temp\initGUI.txt" (
call "%~dp0core\get-drive-root.cmd"
call "%~dp0core\set-global.cmd"
)

if not defined pf (
:: Common OS Paths
set pf=%systemdrive%\Program Files
set cf=%systemdrive%\Program Files\Common Files
set pf64=%systemdrive%\Program Files (x86)
set cf64=%systemdrive%\Program Files (x86)\Common Files
set pd=%ProgramData%
set pdxp=%UserProfile%\Application Data\
set adl=%LocalAppData%
set adll=%SystemDrive%%HomePath%\AppData\LocalLow
set adr=%AppData%
set au=%SystemDrive%\All Users
set auxp=%systemdrive%\Documents and Settings\All Users
set cu=%UserProfile%
set cuxp=%userprofile%\Application Data
set win=%windir%
set sys32=%windir%\system32
set sysprofile=%windir%\system32\config\systemprofile
set userdir=%userprofile%

:: Temp Paths
set temp1=%tempGlobal%
set temp2=%systemdrive%\Temp
set temp3=%windir%\Temp
set temp4=%windir%\system32\config\systemprofile\AppData\Local\Temp
set tempInit=%tempGlobal%
set tempDirectory=%tempInit%
set tempSys=%windir%\TEMP

:: Desktop Paths
set deskau=%public%\Desktop
set deskcu=%SystemDrive%%HomePath%\Desktop

:: Start Menu Paths
set startau=%systemdrive%\Users\All Users\Microsoft\Windows\Start Menu\Programs
set startcu=%AppData%\Microsoft\Windows\Start Menu\Programs

:: Documents Paths
set docsau=%Public%\Documents
set docscu=%UserProfile%\Documents

:: Misc paths used in backup routine (may be unreferenced)
set user=%UserProfile%
set appdata2=%user%\AppData

:: Default Common User Paths
set contacts=%UserProfile%\Contacts
set desktop=%UserProfile%\Desktop
set mydownloads=%UserProfile%\Downloads
set favorites=%UserProfile%\Favorites
set links=%UserProfile%\Links
set mydocuments=%UserProfile%\My Documents
set mymusic=%UserProfile%\My Music
set mypictures=%UserProfile%\My Pictures
set myvideos=%UserProfile%\My Videos
set savedgames=%UserProfile%\Saved Games
set searches=%UserProfile%\Searches

:: Alternate Default Common User Paths
set documents=%UserProfile%\Documents
set downloads=%UserProfile%\Downloads
set pictures=%UserProfile%\Pictures
set music=%UserProfile%\Music
set videos=%UserProfile%\Videos

:: System User Paths
set sysUserRoot=%windir%\system32\config\systemprofile
set sysUserAppData=%windir%\system32\config\systemprofile\AppData
set sysUserAppDataLocal=%windir%\system32\config\systemprofile\AppData\Local
set sysUserAppDataLocalLow=%windir%\system32\config\systemprofile\AppData\LocalLow
set sysUserAppDataRoaming=%windir%\system32\config\systemprofile\AppData\Roaming
set sysUserDesktop=%windir%\system32\config\systemprofile\Desktop
set sysUserDocuments=%windir%\system32\config\systemprofile\Documents
set sysUserDownloads=%windir%\system32\config\systemprofile\Downloads
set sysUserFavorites=%windir%\system32\config\systemprofile\Favorites
set sysUserMusic=%windir%\system32\config\systemprofile\Music
set sysUserPictures=%windir%\system32\config\systemprofile\Pictures
set sysUserVideos=%windir%\system32\config\systemprofile\Videos
)

:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)



:: Enable MSI uninstall in safe mode

if not defined safeModeState goto doWork
if %safeModeState%==inactive goto doWork
if %safeModeState%==minimal "%pclBinPath%\SafeMSI.exe"
if %safeModeState%==network "%pclBinPath%\SafeMSI.exe"
if %safeModeState%==alternateshell "%pclBinPath%\SafeMSI.exe"


:doWork
cls

color 0b

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


:loopdone

endlocal



:end

exit





