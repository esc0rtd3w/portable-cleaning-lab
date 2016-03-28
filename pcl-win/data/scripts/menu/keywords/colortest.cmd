@echo off

mode con lines=33

color 0b

set current=%~dp0
pushd ..
set newRoot=%cd%
popd



set scriptPath="%newRoot%\pcl-win\data\scripts\color-cycle.cmd"
::echo %scriptPath:\\=\%
set scriptPath=%scriptPath:\\=\%
echo %scriptPath%

call %scriptPath%

pause

exit
