@echo off

:: This was the ORIGINAL getDriveRoot script
:: It is here simply for reference

for /l %%a in (1,1,10) do (
    pushd ..
)

set rootDrive=%cd%
popd

setlocal enabledelayedexpansion

set rootDrive=!rootDrive:~0,-1!
set rootDriveLetter=!rootDrive:~0,-1!

echo !rootDrive!>"%windir%\temp\pcl\rootDrive.id"
echo !rootDriveLetter!>"%windir%\temp\pcl\rootDriveLetter.id"

endlocal

:end

