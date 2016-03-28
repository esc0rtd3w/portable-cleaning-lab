@echo off


cls
echo %messagePreparingToLoad%
echo.

:: Check each ui.mode file and if it exists then write that mode to a temp file
if exist "%pclDataPath%\ui.menu" set uiModeOverride=menu
if exist "%pclDataPath%\ui.menu" echo menu>"%pclTempMain%\uiMode.state"

if exist "%pclDataPath%\ui.auto" set uiModeOverride=auto
if exist "%pclDataPath%\ui.auto" echo auto>"%pclTempMain%\uiMode.state"

if exist "%pclDataPath%\ui.easy" set uiModeOverride=easy
if exist "%pclDataPath%\ui.easy" echo easy>"%pclTempMain%\uiMode.state"

if exist "%pclDataPath%\ui.expert" set uiModeOverride=expert
if exist "%pclDataPath%\ui.expert" echo expert>"%pclTempMain%\uiMode.state

if exist "%pclDataPath%\ui.forensics" set uiModeOverride=forensics
if exist "%pclDataPath%\ui.forensics" echo forensics>"%pclTempMain%\uiMode.state

:end

