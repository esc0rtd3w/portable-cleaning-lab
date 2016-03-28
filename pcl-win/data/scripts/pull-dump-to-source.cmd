@echo off

color 0e

cls
echo Copying dump files back to source media...
echo.

::echo pclDumpPathExternal: %pclDumpPathExternal%
::echo pclDumpPathLocal: %pclDumpPathLocal%
::pause

::set pclDumpPathLocal=<%dumpPathCheckFile%

if not exist "%pclDumpPathExternal%" md "%pclDumpPathExternal%"
%cp% "%pclDumpPathLocal%\*" "%pclDumpPathExternal%"


if not exist %dumpPathCheckFile% (
cls
echo No baddie dumps to dump! 
echo.
echo Press ENTER to continue....
echo.
pause>nul
)


:end


exit