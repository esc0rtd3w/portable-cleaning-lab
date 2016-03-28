@echo off

if not exist "%pclTempMain%\" md "%pclTempMain%\"

set | find "target_root"

if errorlevel 1 (
echo disabled>"%pclTempMain%\pemode.state"
goto end
)

if errorlevel 0 (
echo enabled>"%pclTempMain%\pemode.state"
goto end
)

:end

