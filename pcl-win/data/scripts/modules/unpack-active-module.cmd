@echo off

echo.
echo Unpacking....
echo.
echo.

::set tempDirectory=%pclTempUser%
set runDirectory=%pclTempMain%\%moduleActive%
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

:: If the path layout is one layer deep
if %moduleSubTypeLayers%==1 (
%pclExtractModule% "%pclModulesPath%\%moduleType%\%moduleActive%.pcl" "%pclTempMain%"
)

:: If the path layout is two layers deep
if %moduleSubTypeLayers%==2 (
%pclExtractModule% "%pclModulesPath%\%moduleType%\%moduleSubType%\%moduleActive%.pcl" "%pclTempMain%"
)

:: If the path layout is three layers deep
if %moduleSubTypeLayers%==3 (
%pclExtractModule% "%pclModulesPath%\%moduleType%\%moduleSubType%\%moduleSubType3%\%moduleActive%.pcl" "%pclTempMain%"
)


:end

