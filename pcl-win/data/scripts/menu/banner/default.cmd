@echo off

title %titleText%

::set bannerText=[OS: %ostype%/%bits%] [Safe Mode: %safeModeState%] [Network: %networkStatus%] [Mode: %uiMode%]

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.

:end

