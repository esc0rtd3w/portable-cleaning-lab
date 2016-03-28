@echo off


title Module Path Editor :: portablecleaninglab.com


:reset

color 0b

cls
echo Enter New MAIN MODULE path and press ENTER:
echo.
echo.
echo Current: %pclModulesPath%
echo.
echo.

set /p pclModulesPath=

echo %pclModulesPath%>%pclModulesPathEdit%


cls
echo Enter New CLEANING SCANNERS MODULE path and press ENTER:
echo.
echo.
echo Current: %pclModulesCleaningScannersPath%
echo.
echo.


set /p pclModulesCleaningScannersPath=

echo %pclModulesCleaningScannersPath%>%pclModulesCleaningScannersPathEdit%



:choose
set goHomeOrLeave=2
cls
%cocolor% 0b
echo Modules: 
echo %pclModulesPath%
echo.
%cocolor% 0d
echo Cleaning Scanners: 
echo %pclModulesCleaningScannersPath%
echo.
echo.
%cocolor% 0a
echo.
echo Make a selection and press ENTER:
echo.
echo.
echo 1) Go Back and Edit Module Paths
echo.
echo 2) Exit Module Path Editor
echo.
echo.


set /p goHomeOrLeave=

if [%goHomeOrLeave%]==[] goto choose

if %goHomeOrLeave% gtr 2 goto choose


if %goHomeOrLeave%==1 goto reset





exit
