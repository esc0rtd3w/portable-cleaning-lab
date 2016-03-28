@echo off


set titleText=Reading INI File :: portablecleaninglab.com
title %titleText%

::echo.>"%iniReadTempFile%"

for /f "delims=" %%a in ("%inifile% %iniFileCurrent% [%iniSectionCurrent%] %iniItemCurrent%") do %%a>>"%iniReadTempFile%"

call %iniReadTempFile%

:end

