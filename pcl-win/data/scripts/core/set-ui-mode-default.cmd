@echo off

set uiMode=menu
set uiModeOverride=menu
if exist "%pclDataPath%\ui.menu" echo menu>"%pclTempMain%\uiMode.state"

:end

