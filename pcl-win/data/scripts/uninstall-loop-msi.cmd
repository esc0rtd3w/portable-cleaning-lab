@echo off

title Known Baddie Uninstall Loop MSI

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
echo [MSI Mode]
echo.
echo.
echo Press ENTER to start new run....
echo.
echo.
%cocolor% 0a
echo If you recieve the error listed below, click OK to continue
echo.
echo "This action is only valid for products that are currently installed"
%cocolor% 0b
echo.
echo.

set /p doshit=


:: 20140905 Had to remove QUOTES from msiexec path to propery launch

setlocal ENABLEDELAYEDEXPANSION


:: MSI Installers
color 03
set listMSI=%~dp0lists\uninstallMSI.txt
for /f "tokens=*" %%a in (%listMSI%) do (
    set /a listMSI=!listMSI! + 1
    set var!listMSI!=%%a
	echo msiexec.exe /x%%a
	msiexec.exe /x%%a /quiet
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
cls
color 03
set listMSIPUP=%~dp0lists\uninstallMSIPup.txt
for /f "tokens=*" %%a in (%listMSIPUP%) do (
    set /a listMSIPUP=!listMSIPUP! + 1
    set var!listMSIPUP!=%%a
	echo msiexec.exe /x%%a
	msiexec.exe /x%%a /quiet
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
color 03
set listMSIOEM=%~dp0lists\uninstallMSIOEM.txt
for /f "tokens=*" %%a in (%listMSIOEM%) do (
    set /a listMSIOEM=!listMSIOEM! + 1
    set var!listMSIOEM!=%%a
	echo msiexec.exe /x%%a
	msiexec.exe /x%%a /quiet
)


:loopdone

endlocal


goto dowork


:end





