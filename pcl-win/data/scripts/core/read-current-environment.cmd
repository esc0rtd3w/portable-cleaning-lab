@echo off

setlocal enabledelayedexpansion
	
set pclCurrentEnvironment="%windir%\temp\pcl.set"
set pclCurrentEnvironmentBatch="%windir%\temp\systemInit.cmd"
for /f "tokens=* delims=\" %%a in (%pclCurrentEnvironment%) do (
    set /a pclCurrentEnvironment=!pclCurrentEnvironment! + 1
    set var!pclCurrentEnvironment!=%%a
	echo @echo off>%pclCurrentEnvironmentBatch%
	echo.>>%pclCurrentEnvironmentBatch%
	echo set %%a>>%pclCurrentEnvironmentBatch%
	)

endlocal

::call "%pclCurrentEnvironmentBatch%"


:end

