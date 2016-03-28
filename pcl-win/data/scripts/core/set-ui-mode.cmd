@echo off

:: Check the ui.mode file and set the uiMode variable to its value
if exist "%pclTempMain%\uiMode.state" set /p uiMode=<"%pclTempMain%\uiMode.state"
if exist "%pclTempMain%\uiModeOverride.state" set /p uiMode=<"%pclTempMain%\uiModeOverride.state"

:end

