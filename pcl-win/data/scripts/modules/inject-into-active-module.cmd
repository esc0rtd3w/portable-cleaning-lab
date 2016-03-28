@echo off



set targetBase=%pclTempMain%\%moduleActive%
set targetDirName=data
set targetPathFull=%targetBase%\%targetDirName%

set newTarget=0

:reset

title Portable Cleaning Lab Module Inject

mode con lines=33


:menu
cls
%cocolor% 0a
echo Ready To Inject Files!
echo.
echo.
echo Module: %moduleActive%
echo.
if %newTarget%==0 echo Target Path: %targetPathFull%
if %newTarget%==1 echo Target Path: %newTargetPathFull%
echo.
echo.
echo.
%cocolor% 0b
echo Drop a file or a folder into this window and press ENTER to inject....
echo.
echo.
echo You can press T and ENTER to change Target Path!
echo.
echo You can also press X and ENTER to close this window!
echo.
echo.

set /p newBytes=

if %newBytes%==x goto end
if %newBytes%==X goto end

if %newBytes%==t goto target
if %newBytes%==T goto target

set targetBase=%pclTempMain%\%moduleActive%
set targetDirName=data
set targetPathFull=%targetBase%\%targetDirName%

if not exist "%targetPathFull%" md "%targetPathFull%"

if %newTarget%==0 copy /y %newBytes% "%targetPathFull%"
if %newTarget%==1 copy /y %newBytes% "%newTargetPathFull%"

goto reset


:target

set newTarget=1

cls
echo Enter new target path:
echo.
echo.

set /p newTargetPath=

if not exist "%targetPathFull%\%newTargetPath%" md "%targetPathFull%\%newTargetPath%"
copy /y %newBytes% "%targetPathFull%\%newTargetPath%"

set targetBase=%pclTempMain%\%moduleActive%
set targetDirName=data
set targetPathFull=%targetBase%\%targetDirName%

set newTargetPathFull=%targetPathFull%\%newTargetPath%


goto reset



:end

exit

