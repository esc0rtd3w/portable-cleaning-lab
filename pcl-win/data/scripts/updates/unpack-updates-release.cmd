@echo off

set doUnpack=99
cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Unpacking New Updates....
echo.
echo.
echo ITS GONNA
echo.
echo EXTRACT THIS: "%pclTempMain%\%pclReleaseBaseName%-%pclRemoteVersion%.%pclReleaseBaseExt%"
echo.
echo TO HERE: "%targetDrive%\"
echo.
echo.
echo THIS WILL CLOSE THE PCL!
echo.
echo YOUR OLD PCL FOLDER WILL BE ERASED AND ALL FILES WILL BE UPDATED!
echo.
echo Press ENTER to continue or X and ENTER to go back....
echo.
echo.

set /p doUnpack=

if %doUnpack%==X goto end
if %doUnpack%==x goto end

:: Set variables to files that can be accessed by anyone to re-set the environment for extraction of ZIP
::echo %pclRootPath%>"%windir%\temp\pclupdate.dest"
::echo %closeActiveWindowByTitle%>"%windir%\temp\pclupdate.init"
::echo %unpackZip% "%pclTempMain%\%pclReleaseBaseName%-%pclRemoteVersion%.%pclReleaseBaseExt%" -d %targetDrive%\>"%windir%\temp\pclupdate.unpack"


:: Write out to a temp batch file (New Method 20141127)
echo @echo off>"%StandardWindowsTempPath%\update-pcl.cmd"
echo.>>"%StandardWindowsTempPath%\update-pcl.cmd"
echo title Portable Cleaning Lab Updater - portablecleaninglab.com>>"%StandardWindowsTempPath%\update-pcl.cmd"
echo.>>"%StandardWindowsTempPath%\update-pcl.cmd"
echo color 0e>>"%StandardWindowsTempPath%\update-pcl.cmd"
echo.>>"%StandardWindowsTempPath%\update-pcl.cmd"
echo %rmsub% "%pclRootPath%">>"%StandardWindowsTempPath%\update-pcl.cmd"
echo %rmdir% "%pclRootPath%">>"%StandardWindowsTempPath%\update-pcl.cmd"
echo.>>"%StandardWindowsTempPath%\update-pcl.cmd"
echo "%StandardWindowsTempPath%\unzip.exe" "%pclTempMain%\%pclReleaseBaseName%-%pclRemoteVersion%.%pclReleaseBaseExt%" -d %targetDrive%\>>"%StandardWindowsTempPath%\update-pcl.cmd"
echo.>>"%StandardWindowsTempPath%\update-pcl.cmd"
echo exit>>"%StandardWindowsTempPath%\update-pcl.cmd"


%cp2% "%pclBinPath%\unzip.exe" "%StandardWindowsTempPath%"

:: Must spawn the next step externally to close the PCL and update files
%finalizeUpdatesToExternalMedia%

:: Closing the PCL so all files can be updated
cls
exit



:end

