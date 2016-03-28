@echo off

:reset

set getPCLReleaseFromServer=%wgetWithAltSave% "%pclTempMain%\%pclReleaseBaseName%-%pclRemoteVersion%.%pclReleaseBaseExt%" "%updateServer%/%pclReleasePath%/%pclReleaseBaseName%-%pclRemoteVersion%.%pclReleaseBaseExt%"

set pclReleaseZip=%pclTempMain%\%pclReleaseBaseName%-%pclRemoteVersion%.%pclReleaseBaseExt%

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Downloading %pclReleaseZip%....
echo.
echo.
echo Please be patient....
echo.
echo.

%busyPopupDefault%

%getPCLReleaseFromServer%

%busyPopupClose%

::echo %getPCLReleaseFromServer%
::pause


set targetFile=%pclReleaseZip%
::%checkForZeroByteFile%

for %%a in ("%targetFile%") do (
  if %%~za equ 0 (
	set zeroByteFile=1
  ) else (
	set zeroByteFile=0
  )
)

if %zeroByteFile%==1 goto fail


cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0a
echo.
echo Update Download Complete!
echo.
echo.
echo Press ENTER to continue....
echo.
echo.
::pause>nul

%unpackUpdatesRelease%

goto end


:fail
set updateFailedRetry=99
cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0c
echo.
echo Update Download Failed!
echo.
echo.
echo Press ENTER to try again or C and ENTER continue....
echo.
echo.

set /p updateFailedRetry=

if %updateFailedRetry%==C goto end
if %updateFailedRetry%==c goto end

goto reset



:end


