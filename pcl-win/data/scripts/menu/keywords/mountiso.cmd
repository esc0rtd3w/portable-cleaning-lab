@echo off

mode con lines=33

color 0b

set current=%~dp0
pushd ..
set newRoot=%cd%
popd



set imdiskModule="%newRoot%\pcl-win\data\modules\misc\imdisk.pcl"

%pclExtract% %imdiskModule% "%temp%"

cmd /c "%temp%\imdisk\launch.cmd"

pause


exit