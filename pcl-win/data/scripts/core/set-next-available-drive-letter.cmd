@echo off

set /p virtualDriveLetter=<"%pclTempMain%\pclModuleTempDriveLetter.tmp"
set virtualDriveLetter=%virtualDriveLetter%:

set virtualTempDriveCreate=subst %virtualDriveLetter% "%pclModuleTempPath%"
set virtualTempDriveDestroy=subst %virtualDriveLetter% /d


:end