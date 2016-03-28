@echo off

%bannerMenuDefault%

echo.
echo This script is currently broken!
echo.
echo Exiting in 5 seconds....
echo.

%wait% 5

goto end

::%psexecElevateToSystem% "%pclRootPath%\%pclMainScript%"

:end
