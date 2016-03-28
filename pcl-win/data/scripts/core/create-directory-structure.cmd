@echo off
echo %pclTempUpdates%

if not exist "%pclTempUpdates%\data" md "%pclTempUpdates%\data"
if not exist "%pclTempUpdates%\data\bin" md "%pclTempUpdates%\data\bin"
if not exist "%pclTempUpdates%\data\config" md "%pclTempUpdates%\data\config"
if not exist "%pclTempUpdates%\data\modules" md "%pclTempUpdates%\data\modules"
if not exist "%pclTempUpdates%\data\registry" md "%pclTempUpdates%\data\registry"
if not exist "%pclTempUpdates%\data\scripts" md "%pclTempUpdates%\data\scripts"
if not exist "%pclTempUpdates%\data\templates" md "%pclTempUpdates%\data\templates"
if not exist "%pclTempUpdates%\data\text" md "%pclTempUpdates%\data\text"
if not exist "%pclTempUpdates%\data\updates" md "%pclTempUpdates%\data\updates"


:end

