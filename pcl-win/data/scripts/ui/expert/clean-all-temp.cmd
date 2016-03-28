@echo off

:reset

%bannerMenuDefault%

echo Cleaning Temp Files From Known Locations....

:: Cccleaner Auto-Clean
::"%pclBinPath%\ccleaner.exe" /auto

%bannerMenuDefault%

echo Cleaning Temp Files From Known Locations....

:: Normal Temp Folder
for /d %%a in (%temp1%\*) do %rmdir% "%%a"
%rmsub% "%temp1%\*"

:: C:\Temp Folder
for /d %%b in (%temp2%\*) do %rmdir% "%%b"
%rmsub% "%temp2%\*"

:: C:\Windows\Temp Folder
for /d %%b in (%temp3%\*) do %rmdir% "%%b"
%rmsub% "%temp3%\*"

:: C:\Windows\System32\config\systemprofile\AppData\Local\Temp Folder
if exist "%temp4%" for /d %%c in (%temp4%\*) do %rmdir% "%%c"
if exist "%temp4%" %rmsub% "%temp4%\*"

goto chkExit



:chkExit

if %menuItem%==B set exitStatus=back
if %menuItem%==b set exitStatus=back

if %menuItem%==X set exitStatus=close
if %menuItem%==x set exitStatus=close

:: If an exitStatus is not set then set it to return as default
::if not defined exitStatus set exitStatus=return

::if %exitStatus%==return goto reset

goto end


:end

