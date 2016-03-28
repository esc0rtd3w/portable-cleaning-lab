@echo off


set /p rootDrive=<"%pclTempMain%\rootDrive.id"


defrag %rootDrive% /u /v

exit
