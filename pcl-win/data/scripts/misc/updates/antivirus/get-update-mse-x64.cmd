@echo off

:: Gets current running directory of batch file
set runPath=%~dp0

set tempPath=%temp%
set savePath=%runPath%
set linkPath=http://go.microsoft.com/fwlink/?LinkID=87341

:: Get update exe name
set updateFile=mpam-feX64.exe


:getRootDrive

for /l %%a in (1,1,10) do (
    pushd ..
)

set root=%cd%
popd
::echo root: %root%

set wget="%root%data\wget.exe"


%wget% -O "%tempPath%\%updateFile%" %linkPath%


::pause

echo Copying New Update to Portable Media....
echo.


xcopy "%tempPath%\%updateFile%" "%savePath%" /q /r /y

::pause


:end


