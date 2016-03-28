@echo off

%bannerMenuDefault%

echo Checking INI Config Files....
echo.

for /f "delims=" %%a in ('dir /a-d /b "%pclConfigPath%"') do echo "%pclConfigPath%\%%~na.ini"

::pause

:end

