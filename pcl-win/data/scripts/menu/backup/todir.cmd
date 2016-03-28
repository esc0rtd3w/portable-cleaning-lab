@echo off




call "%~dp0todest.cmd"

if not exist "%destination%\%destDir%" md "%destination%\%destDir%"

echo "%source%\*" "%destination%\%destDir%\"

takeown /f "%source%" /r /d y && icacls "%source%" /grant administrators:F

xcopy "%source%\*" "%destination%\%destDir%\" /s /e /y /f
::xcopy "%source%\*.*" "%destination%\%destDir%\" /e /y

::explorer "%destination%\%destDir%\"


:end


