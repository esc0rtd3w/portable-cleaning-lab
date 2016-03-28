@echo off

color 0e

cls
echo Disabling All GWX Related Functions....
echo.

%regImportFromFile% "%pclRegistryPath%\disable-gwx.reg"

%wait% 5


:end

exit