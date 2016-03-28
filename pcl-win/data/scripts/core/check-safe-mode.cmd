@echo off

if not exist "%pclTempMain%\" md "%pclTempMain%\"

set | find "SAFEBOOT_OPTION"

if errorlevel 1 (
echo inactive>"%pclTempMain%\safemode.state"
goto end
)

if errorlevel 0 (
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" echo minimal>"%pclTempMain%\safemode.state"
if /i "%SAFEBOOT_OPTION%"=="NETWORK" echo network>"%pclTempMain%\safemode.state"
if /i "%SAFEBOOT_OPTION%"=="MINIMAL_ALTERNATE_SHELL" echo alternateshell>"%pclTempMain%\safemode.state"
)

:end

