@echo off


::set pf=%systemdrive%\Program Files
set pf=%ProgramFiles%
set cf=%systemdrive%\Program Files\Common Files
set pf64=%systemdrive%\Program Files (x86)
::set pf64=%ProgramFiles(x86)%
set cf64=%systemdrive%\Program Files (x86)\Common Files
set pd=%ProgramData%
set pdxp=C:\Documents and Settings\%UserName%\Application Data
set adl=%LocalAppData%
set adlxp=%UserProfile%\Local Settings\Application Data\Local
set adll=%SystemDrive%%HomePath%\AppData\LocalLow
set adllxp=%UserProfile%\Local Settings\Application Data\LocalLow
set adr=%AppData%
set adrxp=%UserProfile%\Local Settings\Application Data\Roaming
set au=%AllUsersProfile%
set auxp=C:\Documents and Settings\All Users
set cu=%UserProfile%
set win=%systemdrive%\Windows
set sys32=%systemdrive%\Windows\system32
set sysprofile=%windir%\system32\config\systemprofile
set userdir=%userprofile%
set mydocs=%userprofile%\My Documents
set mydownloads=%userprofile%\Downloads
set temp1=%temp%
set temp2=%systemdrive%\Temp
set temp3=%windir%\Temp
set temp4=%windir%\system32\config\systemprofile\AppData\Local\Temp


set deskau=%public%\Desktop
set deskcu=%SystemDrive%%HomePath%\Desktop

set startau=%systemdrive%\Users\All Users\Microsoft\Windows\Start Menu\Programs
set startcu=%AppData%\Microsoft\Windows\Start Menu\Programs

::set docsau=%UserProfile%\Documents
set docscu=%UserProfile%\Documents


:: Registry Paths

set regHKCR=HKEY_CLASSES_ROOT
set regHKCU=HKEY_CURRENT_USER
set regHKLM=HKEY_LOCAL_MACHINE
set regHKU=HKEY_USERS
set regHKCC=HKEY_CURRENT_USER


:: Other Paths
::set dumpPath=%AllUsersProfile%\pcl\dumps
if not exist "%pclTempMain%\dump.path" echo %AllUsersProfile%\pcl\dumps>"%pclTempMain%\dump.path"
if exist "%pclTempMain%\dump.path" set /p dumpPath=<"%pclTempMain%\dump.path"





:end

