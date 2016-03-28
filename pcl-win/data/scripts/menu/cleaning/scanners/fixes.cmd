@echo off

:start

set scannerName=0

::if %moduleActive%==clamwin set scannerName=Clamwin
::if %moduleActive%==panda set scannerName=Panda
::if %moduleActive%==spybot set scannerName=Spybot

::if %moduleActive%==clamwin goto generic
::if %moduleActive%==panda goto generic
::if %moduleActive%==spybot goto generic



goto end


:generic

set doubleLaunchFix=1

:: If no available fixes, then EXIT
if %scannerName%==0 goto end

explorer "%pclTempMain%\%moduleActive%"

cls
echo The %scannerName% folder should now be open!
echo.
echo.
::if %fixtype%==repack echo Launch the update.cmd manually to perform definition update.
::if %fixtype%==update echo Launch the update.cmd manually to perform definition update.
::if %fixtype%==scan echo Launch the launch.cmd manually to start scanning.
::if %fixtype%==scanupdate echo Launch the update.cmd manually to perform definition update.
::if %fixtype%==scanupdate echo.
::if %fixtype%==scanupdate echo Launch the launch.cmd manually to start scanning.
echo Launch the update.cmd manually to perform definition update.
echo.
echo Launch the launch.cmd manually to start scanning.
echo.
echo.
echo You may also close the window that was opened after update is complete!
echo.
echo.
echo Press ENTER when finished
echo.
echo.
pause>nul

goto end




:end



