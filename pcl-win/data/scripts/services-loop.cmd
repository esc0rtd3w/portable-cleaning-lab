@echo off

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




:doWork

:: Create a service
::sc create "%serviceName%" binpath= "%runDirectory%\data\%appBin%" start= demand DisplayName= "%serviceDisplayName%" error= ignore

:: Create a service (alternate)
::instsrv.exe "%serviceName%" "%runDirectory%\data\srvany.exe"

:: Start a service
::sc start "%serviceName%" binpath= "%runDirectory%\data\%appBin%"

:: Stop a service
::net stop %serviceName%

:: Delete a service
::sc delete "%serviceName%"

set svcStop=net stop
set svcDelete=sc delete

color 0b

cls
echo [SERVICES Mode]
echo.
echo.
echo Press ENTER to start new run....
echo.
echo.

set /p doshit=



setlocal ENABLEDELAYEDEXPANSION

:: Main svcList targets
color 0b
set listServiceList=%~dp0lists\svcList.txt
for /f "tokens=*" %%a in (%listServiceList%) do (
    set /a listServiceList=!listServiceList! + 1
    set var!listServiceList!=%%a
	echo %svcStop% "%%a"
	echo %svcDelete% "%%a"
	%svcStop% "%%a"
	%svcDelete% "%%a"
)



:askpup
color 0a

set removePUP=n

cls
echo Remove Potentially Unwanted Programs Entries (PUP)? [Y/N]:
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
color 0a
set listServiceListPUP=%~dp0lists\svcListPUP.txt
for /f "tokens=*" %%a in (%listServiceListPUP%) do (
    set /a listServiceListPUP=!listServiceListPUP! + 1
    set var!listServiceListPUP!=%%a
	echo %svcStop% "%%a"
	echo %svcDelete% "%%a"
	%svcStop% "%%a"
	%svcDelete% "%%a"
)



:askoem
color 0d

set removeOEM=n

cls
echo Remove OEM Crapware Entries? [Y/N]:
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

color 0d
set listServiceListOEM=%~dp0lists\svcListOEM.txt
for /f "tokens=*" %%a in (%listServiceListOEM%) do (
    set /a listServiceListOEM=!listServiceListOEM! + 1
    set var!listServiceListOEM!=%%a
	echo %svcStop% "%%a"
	echo %svcDelete% "%%a"
	%svcStop% "%%a"
	%svcDelete% "%%a"
)


:loopdone

endlocal


goto dowork


:end





