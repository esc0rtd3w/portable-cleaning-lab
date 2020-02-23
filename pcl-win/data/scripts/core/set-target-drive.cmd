@echo off



:: Target Drive Related
::set targetDrive=%rootDrive%
::set targetDriveLetter=%rootDriveLetter%
::set targetDriveToClean=%systemdrive%

::set targetDrive=C:
::set targetDriveLetter=C
::set targetDriveToClean=C:

set targetDrive=%SystemDrive%
set targetDriveLetter=%SystemDrive:~0,-1%
set targetDriveToClean=%SystemDrive%

set targetDriveDefault=C:
set targetDriveLetterDefault=C

set targetDriveDefaultPE=X:
set targetDriveLetterDefaultPE=X

:: Used in PE Environment
::set target_root=C:\Windows


::echo targetDrive: %targetDrive%
::echo targetDriveLetter: %targetDriveLetter%
::echo targetDriveToClean: %targetDriveToClean%
::echo targetDriveDefault: %targetDriveDefault%
::echo targetDriveLetterDefault: %targetDriveLetterDefault%
::echo targetDriveDefaultPE: %targetDriveDefaultPE%
::echo targetDriveLetterDefaultPE: %targetDriveLetterDefaultPE%
::pause
