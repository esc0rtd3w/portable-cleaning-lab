@echo off

title Known Baddie File and Folder Removal Loop (Counter Mode)

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


:: Setting removal commands
set rm=rmdir /s /q
::set rm=rd /s /q
set del=del /f /q
set delsub=del /f /s /q

:: Setting pwn Commands
set pwnLeft=takeown /f
set pwnRight=/a /r

set pwnLeft2=icacls
set pwnRight2=/grant:r User:F /T


:doWork


color 0b

cls
%cocolor% 0a
echo This is based off the rmLoop script, modified to run an incremental counter!
echo.
echo If stuck in a loop of the same target, you may close the window and restart.
echo.
echo.
echo.
%cocolor% 0b
echo Press ENTER to start new run....
echo.
echo.
echo.
echo.
%cocolor% 0c
echo ---------------------------------------------------------------------------
echo WARNING!!!   WARNING!!!   WARNING!!!   WARNING!!!   WARNING!!!   WARNING!!!
echo ---------------------------------------------------------------------------
echo.
%cocolor% 0b
echo ALTHOUGH THIS SCRIPT ATTEMPTS TO BE AS SAFE AS POSSIBLE, PLEASE MAKE
echo SURE YOU HAVE BACKED UP ANY IMPORTANT DATA BEFORE CONTINUING!!
echo.
%cocolor% 0c
echo ---------------------------------------------------------------------------
echo WARNING!!!   WARNING!!!   WARNING!!!   WARNING!!!   WARNING!!!   WARNING!!!
echo ---------------------------------------------------------------------------
echo.
echo.

set /p doshit=


setlocal ENABLEDELAYEDEXPANSION

:: Program Files
color 0b
set listPF=%~dp0lists\uninstallPF.txt
for /f "tokens=1 delims=\" %%a in (%listPF%) do (
    set /a listPF=!listPF! + 1
    set var!listPF!=%%a
	echo "%pf%\%%a"
	%pwnLeft% "%pf%\%%a" %pwnRight%
	%rm% "%pf%\%%a"
)

:: Program Files (Targeted File)
color 0b
set listPF2=%~dp0lists\rmListPF.txt
for /f "tokens=* delims=\" %%a in (%listPF2%) do (
    set /a listPF2=!listPF2! + 1
    set var!listPF2!=%%a
	echo "%pf%\%%a"
	%pwnLeft% "%pf%\%%a" %pwnRight%
	%rm% "%pf%\%%a"
)

:: Program Files (x86)
color 0d
set listPF64=%~dp0lists\uninstallPF.txt
for /f "tokens=1 delims=\" %%a in (%listPF64%) do (
    set /a listPF64=!listPF64! + 1
    set var!listPF64!=%%a
	echo "%pf64%\%%a"
	%pwnLeft% "%pf64%\%%a" %pwnRight%
	%rm% "%pf64%\%%a"
)

:: Program Files (x86) (Targeted File)
color 0d
set listPF642=%~dp0lists\rmListPF.txt
for /f "tokens=* delims=\" %%a in (%listPF642%) do (
    set /a listPF642=!listPF642! + 1
    set var!listPF642!=%%a
	echo "%pf64%\%%a"
	%pwnLeft% "%pf64%\%%a" %pwnRight%
	%rm% "%pf64%\%%a"
)

:: Common Files (x86) (Targeted File)
color 0d
set listCF32=%~dp0lists\rmListCF.txt
for /f "tokens=* delims=\" %%a in (%listCF32%) do (
    set /a listCF32=!listCF32! + 1
    set var!listCF32!=%%a
	echo "%cf%\%%a"
	%pwnLeft% "%cf%\%%a" %pwnRight%
	%rm% "%cf%\%%a"
)

:: Common Files (x64) (Targeted File)
color 0d
set listCF64=%~dp0lists\rmListCF.txt
for /f "tokens=* delims=\" %%a in (%listCF64%) do (
    set /a listCF64=!listCF64! + 1
    set var!listCF64!=%%a
	echo "%cf64%\%%a"
	%pwnLeft% "%cf64%\%%a" %pwnRight%
	%rm% "%cf64%\%%a"
)

:: Common Files (x86) (Uninstall)
color 0b
set listCF=%~dp0lists\uninstallCF.txt
for /f "tokens=1 delims=\" %%a in (%listCF%) do (
    set /a listCF=!listCF! + 1
    set var!listCF!=%%a
	echo "%cf%\%%a"
	%pwnLeft% "%cf%\%%a" %pwnRight%
	%rm% "%cf%\%%a"
)

:: Common Files (x64) (Uninstall)
color 0d
set listCF64=%~dp0lists\uninstallCF.txt
for /f "tokens=1 delims=\" %%a in (%listCF64%) do (
    set /a listCF64=!listCF64! + 1
    set var!listCF64!=%%a
	echo "%cf64%\%%a"
	%pwnLeft% "%cf64%\%%a" %pwnRight%
	%rm% "%cf64%\%%a"
)

:: ProgramData
color 0a
set listPD=%~dp0lists\uninstallPD.txt
for /f "tokens=1 delims=\" %%a in (%listPD%) do (
    set /a listPD=!listPD! + 1
    set var!listPD!=%%a
	echo "%pd%\%%a"
	%pwnLeft% "%pd%\%%a" %pwnRight%
	%rm% "%pd%\%%a"
)

:: ProgramData (Targeted File)
color 0a
set listPD2=%~dp0lists\rmListPD.txt
for /f "tokens=* delims=\" %%a in (%listPD2%) do (
    set /a listPD2=!listPD2! + 1
    set var!listPD2!=%%a
	echo "%pd%\%%a"
	%pwnLeft% "%pd%\%%a" %pwnRight%
	%rm% "%pd%\%%a"
)

:: AllUsers
color 0a
set listPD=%~dp0lists\uninstallPD.txt
for /f "tokens=1 delims=\" %%a in (%listPD%) do (
    set /a listPD=!listPD! + 1
    set var!listPD!=%%a
	echo "%au%\%%a"
	%pwnLeft% "%au%\%%a" %pwnRight%
	%rm% "%au%\%%a"
)

:: AppData-Local
color 05
set listADL=%~dp0lists\uninstallADL.txt
for /f "tokens=1 delims=\" %%a in (%listADL%) do (
    set /a listADL=!listADL! + 1
    set var!listADL!=%%a
	echo "%adl%\%%a"
	%pwnLeft% "%adl%\%%a" %pwnRight%
	%rm% "%adl%\%%a"
)

:: AppData-Local (Targeted File)
color 05
set listADL2=%~dp0lists\rmListADL.txt
for /f "tokens=* delims=\" %%a in (%listADL2%) do (
    set /a listADL2=!listADL2! + 1
    set var!listADL2!=%%a
	echo "%adl%\%%a"
	%pwnLeft% "%adl%\%%a" %pwnRight%
	%rm% "%adl%\%%a"
)

:: AppData-LocalLow
color 04
set listADLL=%~dp0lists\uninstallADLL.txt
for /f "tokens=1 delims=\" %%a in (%listADLL%) do (
    set /a listADLL=!listADLL! + 1
    set var!listADLL!=%%a
	echo "%adll%\%%a"
	%pwnLeft% "%adll%\%%a" %pwnRight%
	%rm% "%adll%\%%a"
)

:: AppData-LocalLow (Targeted File)
color 04
set listADLL2=%~dp0lists\rmListADLL.txt
for /f "tokens=* delims=\" %%a in (%listADLL2%) do (
    set /a listADLL2=!listADLL2! + 1
    set var!listADLL2!=%%a
	echo "%adll%\%%a"
	%pwnLeft% "%adll%\%%a" %pwnRight%
	%rm% "%adll%\%%a"
)

:: AppData-Roaming
color 03
set listADR=%~dp0lists\uninstallADR.txt
for /f "tokens=1 delims=\" %%a in (%listADR%) do (
    set /a listADR=!listADR! + 1
    set var!listADR!=%%a
	echo "%adr%\%%a"
	%pwnLeft% "%adr%\%%a" %pwnRight%
	%rm% "%adr%\%%a"
)

:: AppData-Roaming (Targeted File)
color 03
set listADR2=%~dp0lists\rmListADR.txt
for /f "tokens=* delims=\" %%a in (%listADR2%) do (
    set /a listADR2=!listADR2! + 1
    set var!listADR2!=%%a
	echo "%adr%\%%a"
	%pwnLeft% "%adr%\%%a" %pwnRight%
	%rm% "%adr%\%%a"
)


:: Desktop Shortcuts
cls
color 01
set listDesktop=%~dp0lists\rmListDesktop.txt
for /f "tokens=* delims=\" %%a in (%listDesktop%) do (
    set /a listDesktop=!listDesktop! + 1
    set var!listDesktop!=%%a

	echo "%deskau%\%%a.lnk"
	%pwnLeft% "%deskau%\%%a.lnk" %pwnRight%
	%del% "%deskau%\%%a.lnk"
	echo "%deskcu%\%%a.lnk"
	%pwnLeft% "%deskcu%\%%a.lnk" %pwnRight%
	%del% "%deskcu%\%%a.lnk"

)


:: Start Menu Shortcuts
cls
color 01
set listStartMenu=%~dp0lists\rmListStartMenu.txt
for /f "tokens=* delims=\" %%a in (%listStartMenu%) do (
    set /a listStartMenu=!listStartMenu! + 1
    set var!listStartMenu!=%%a

	echo "%startau%\%%a.lnk"
	%pwnLeft% "%startau%\%%a.lnk" %pwnRight%
	%del% "%startau%\%%a.lnk"
	echo "%startcu%\%%a.lnk"
	%pwnLeft% "%startcu%\%%a.lnk" %pwnRight%
	%del% "%startcu%\%%a.lnk"

)


:: Leftover rmList
color 02
set rmList=%~dp0lists\rmList.txt
for /f "tokens=* delims=\" %%a in (%rmList%) do (
    set /a rmList=!rmList! + 1
    set var!rmList!=%%a
	echo "%pd%\%%a"
	%pwnLeft% "%pd%\%%a" %pwnRight%
	%rm% "%pd%\%%a"
	echo "%adl%\%%a"
	%pwnLeft% "%adl%\%%a" %pwnRight%
	%rm% "%adl%\%%a"
	echo "%adll%\%%a"
	%pwnLeft% "%adll%\%%a" %pwnRight%
	%rm% "%adll%\%%a"
	echo "%adr%\%%a"
	%pwnLeft% "%adr%\%%a" %pwnRight%
	%rm% "%adr%\%%a"
	echo "%cf%\%%a"
	%pwnLeft% "%cf%\%%a" %pwnRight%
	%rm% "%cf%\%%a"
	echo "%cf64%\%%a"
	%pwnLeft% "%cf64%\%%a" %pwnRight%
	%rm% "%cf64%\%%a"
	echo "%pf%\%%a"
	%pwnLeft% "%pf%\%%a" %pwnRight%
	%rm% "%pf%\%%a"
	echo "%pf64%\%%a"
	%pwnLeft% "%pf64%\%%a" %pwnRight%
	%rm% "%pf64%\%%a"
	echo "%deskau%\%%a"
	%pwnLeft% "%deskau%\%%a" %pwnRight%
	%rm% "%deskau%\%%a"
	echo "%deskcu%\%%a"
	%pwnLeft% "%deskcu%\%%a" %pwnRight%
	%rm% "%deskcu%\%%a"
	echo "%startau%\%%a"
	%pwnLeft% "%startau%\%%a" %pwnRight%
	%rm% "%startau%\%%a"
	echo "%startcu%\%%a"
	%pwnLeft% "%startcu%\%%a" %pwnRight%
	%rm% "%startcu%\%%a"
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
	%pwnLeft% "%pd%\%%a" %pwnRight%
	%rm% "%pd%\%%a"
	echo "%adl%\%%a"
	%pwnLeft% "%adl%\%%a" %pwnRight%
	%rm% "%adl%\%%a"
	echo "%adll%\%%a"
	%pwnLeft% "%adll%\%%a" %pwnRight%
	%rm% "%adll%\%%a"
	echo "%adr%\%%a"
	%pwnLeft% "%adr%\%%a" %pwnRight%
	%rm% "%adr%\%%a"
	echo "%cf%\%%a"
	%pwnLeft% "%cf%\%%a" %pwnRight%
	%rm% "%cf%\%%a"
	echo "%cf64%\%%a"
	%pwnLeft% "%cf64%\%%a" %pwnRight%
	%rm% "%cf64%\%%a"
	echo "%pf%\%%a"
	%pwnLeft% "%pf%\%%a" %pwnRight%
	%rm% "%pf%\%%a"
	echo "%pf64%\%%a"
	%pwnLeft% "%pf64%\%%a" %pwnRight%
	%rm% "%pf64%\%%a"
)



:: Other PUP
color 02
set listPUP=%~dp0lists\uninstallPUP.txt
for /f "tokens=1 delims=\" %%a in (%listPUP%) do (
    set /a listPUP=!listPUP! + 1
    set var!listPUP!=%%a
	echo "%pd%\%%a"
	%pwnLeft% "%pd%\%%a" %pwnRight%
	%rm% "%pd%\%%a"
	echo "%adl%\%%a"
	%pwnLeft% "%adl%\%%a" %pwnRight%
	%rm% "%adl%\%%a"
	echo "%adll%\%%a"
	%pwnLeft% "%adll%\%%a" %pwnRight%
	%rm% "%adll%\%%a"
	echo "%adr%\%%a"
	%pwnLeft% "%adr%\%%a" %pwnRight%
	%rm% "%adr%\%%a"
	echo "%cf%\%%a"
	%pwnLeft% "%cf%\%%a" %pwnRight%
	%rm% "%cf%\%%a"
	echo "%cf64%\%%a"
	%pwnLeft% "%cf64%\%%a" %pwnRight%
	%rm% "%cf64%\%%a"
	echo "%pf%\%%a"
	%pwnLeft% "%pf%\%%a" %pwnRight%
	%rm% "%pf%\%%a"
	echo "%pf64%\%%a"
	%pwnLeft% "%pf64%\%%a" %pwnRight%
	%rm% "%pf64%\%%a"
	echo "%deskau%\%%a"
	%pwnLeft% "%deskau%\%%a" %pwnRight%
	%rm% "%deskau%\%%a"
	echo "%deskcu%\%%a"
	%pwnLeft% "%deskcu%\%%a" %pwnRight%
	%rm% "%deskcu%\%%a"
	echo "%startau%\%%a"
	%pwnLeft% "%startau%\%%a" %pwnRight%
	%rm% "%startau%\%%a"
	echo "%startcu%\%%a"
	%pwnLeft% "%startcu%\%%a" %pwnRight%
	%rm% "%startcu%\%%a"
)


:: Desktop Shortcuts PUP
cls
color 04
set listDesktopPup=%~dp0lists\rmPUPDesktop.txt
for /f "tokens=1 delims=\" %%a in (%listDesktopPup%) do (
    set /a listDesktopPup=!listDesktopPup! + 1
    set var!listDesktopPup!=%%a

	echo "%deskau%\%%a.lnk"
	%pwnLeft% "%deskau%\%%a.lnk" %pwnRight%
	%del% "%deskau%\%%a.lnk"
	echo "%deskcu%\%%a.lnk"
	%pwnLeft% "%deskcu%\%%a.lnk" %pwnRight%
	%del% "%deskcu%\%%a.lnk"
	
	echo "%deskau%\%%a"
	%pwnLeft% "%deskau%\%%a" %pwnRight%
	%rm% "%deskau%\%%a"
	echo "%deskcu%\%%a"
	%pwnLeft% "%deskcu%\%%a" %pwnRight%
	%rm% "%deskcu%\%%a"

)


:: Start Menu Shortcuts PUP
cls
color 01
set listStartMenuPup=%~dp0lists\rmPUPStartMenu.txt
for /f "tokens=1 delims=\" %%a in (%listStartMenuPup%) do (
    set /a listStartMenuPup=!listStartMenuPup! + 1
    set var!listStartMenuPup!=%%a

	echo "%startau%\%%a.lnk"
	%pwnLeft% "%startau%\%%a.lnk" %pwnRight%
	%del% "%startau%\%%a.lnk"
	echo "%startcu%\%%a.lnk"
	%pwnLeft% "%startcu%\%%a.lnk" %pwnRight%
	%del% "%startcu%\%%a.lnk"
	
	echo "%startau%\%%a"
	%pwnLeft% "%startau%\%%a" %pwnRight%
	%rm% "%startau%\%%a"
	echo "%startcu%\%%a"
	%pwnLeft% "%startcu%\%%a" %pwnRight%
	%rm% "%startcu%\%%a"

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
	%pwnLeft% "%pd%\%%a" %pwnRight%
	%rm% "%pd%\%%a"
	echo "%adl%\%%a"
	%pwnLeft% "%adl%\%%a" %pwnRight%
	%rm% "%adl%\%%a"
	echo "%adll%\%%a"
	%pwnLeft% "%adll%\%%a" %pwnRight%
	%rm% "%adll%\%%a"
	echo "%adr%\%%a"
	%pwnLeft% "%adr%\%%a" %pwnRight%
	%rm% "%adr%\%%a"
	echo "%cf%\%%a"
	%pwnLeft% "%cf%\%%a" %pwnRight%
	%rm% "%cf%\%%a"
	echo "%cf64%\%%a"
	%pwnLeft% "%cf64%\%%a" %pwnRight%
	%rm% "%cf64%\%%a"
	echo "%pf%\%%a"
	%pwnLeft% "%pf%\%%a" %pwnRight%
	%rm% "%pf%\%%a"
	echo "%pf64%\%%a"
	%pwnLeft% "%pf64%\%%a" %pwnRight%
	%rm% "%pf64%\%%a"
)


cls
color 01
set listOEM=%~dp0lists\uninstallOEM.txt
for /f "tokens=1 delims=\" %%a in (%listOEM%) do (
    set /a listOEM=!listOEM! + 1
    set var!listOEM!=%%a
	echo "%pd%\%%a"
	%pwnLeft% "%pd%\%%a" %pwnRight%
	%rm% "%pd%\%%a"
	echo "%adl%\%%a"
	%pwnLeft% "%adl%\%%a" %pwnRight%
	%rm% "%adl%\%%a"
	echo "%adll%\%%a"
	%pwnLeft% "%adll%\%%a" %pwnRight%
	%rm% "%adll%\%%a"
	echo "%adr%\%%a"
	%pwnLeft% "%adr%\%%a" %pwnRight%
	%rm% "%adr%\%%a"
	echo "%cf%\%%a"
	%pwnLeft% "%cf%\%%a" %pwnRight%
	%rm% "%cf%\%%a"
	echo "%cf64%\%%a"
	%pwnLeft% "%cf64%\%%a" %pwnRight%
	%rm% "%cf64%\%%a"
	echo "%pf%\%%a"
	%pwnLeft% "%pf%\%%a" %pwnRight%
	%rm% "%pf%\%%a"
	echo "%pf64%\%%a"
	%pwnLeft% "%pf64%\%%a" %pwnRight%
	%rm% "%pf64%\%%a"
)




:: Desktop Shortcuts OEM
cls
color 04
set listDesktopOEM=%~dp0lists\rmOEMDesktop.txt
for /f "tokens=1 delims=\" %%a in (%listDesktopOEM%) do (
    set /a listDesktopOEM=!listDesktopOEM! + 1
    set var!listDesktopOEM!=%%a

	echo "%deskau%\%%a.lnk"
	%pwnLeft% "%deskau%\%%a.lnk" %pwnRight%
	%del% "%deskau%\%%a.lnk"
	echo "%deskcu%\%%a.lnk"
	%pwnLeft% "%deskcu%\%%a.lnk" %pwnRight%
	%del% "%deskcu%\%%a.lnk"
	
	echo "%deskau%\%%a"
	%pwnLeft% "%deskau%\%%a" %pwnRight%
	%rm% "%deskau%\%%a"
	echo "%deskcu%\%%a"
	%pwnLeft% "%deskcu%\%%a" %pwnRight%
	%rm% "%deskcu%\%%a"

)


:: Start Menu Shortcuts OEM
cls
color 01
set listStartMenuOEM=%~dp0lists\rmOEMStartMenu.txt
for /f "tokens=1 delims=\" %%a in (%listStartMenuOEM%) do (
    set /a listStartMenuOEM=!listStartMenuOEM! + 1
    set var!listStartMenuOEM!=%%a

	echo "%startau%\%%a.lnk"
	%pwnLeft% "%startau%\%%a.lnk" %pwnRight%
	%del% "%startau%\%%a.lnk"
	echo "%startcu%\%%a.lnk"
	%pwnLeft% "%startcu%\%%a.lnk" %pwnRight%
	%del% "%startcu%\%%a.lnk"
	
	echo "%startau%\%%a"
	%pwnLeft% "%startau%\%%a" %pwnRight%
	%rm% "%startau%\%%a"
	echo "%startcu%\%%a"
	%pwnLeft% "%startcu%\%%a" %pwnRight%
	%rm% "%startcu%\%%a"

)



:loopdone

endlocal


goto dowork


:end

exit




