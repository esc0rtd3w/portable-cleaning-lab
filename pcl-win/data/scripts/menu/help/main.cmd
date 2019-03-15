@echo off

mode con lines=29

title Portable Cleaning Lab Help and Reference

color 0a


:helpMain

set helpTask=99

cls
%cocolor% 0f
echo %bannerText%
echo.
%cocolor% 0d
echo.
echo Choose a help topic and press ENTER:
echo.
echo.
echo 1) Menu Navigation
echo.
echo 2) Real World Examples
echo.
echo 3) Show Hidden Keywords
echo.
echo 4) Display PCL Version History
echo.
echo 5) Display Current Known Issues
echo.
echo 6) Display Current "To Do" List
echo.
echo.
echo.
echo X) Exit This Window
echo.



set /p helpTask=


if [%helpTask%]==[] goto helpMain

if %helpTask%==X goto end
if %helpTask%==x goto end

if %helpTask% gtr 6 goto helpMain

if %helpTask%==1 goto helpMain
if %helpTask%==2 goto helpMain
if %helpTask%==3 goto keywords
if %helpTask%==4 %displayVersionInfoExternal%
if %helpTask%==5 %displayKnownIssuesExternal%
if %helpTask%==6 %displayTodoListExternal%

goto helpMain


:keywords

set current=%~dp0
pushd ..
set newRoot=%cd%
popd

set kwPath="%newRoot%\pcl-win\data\scripts\menu\keywords"
set kwPath=%kwPath:\\=\%

::echo %kwPath%
::pause

cls
color 0b
echo Hidden Keywords can be typed at the Main Expert Menu to launch
echo.

::dir /b %kwPath%
for /f "delims=" %%a in ('dir /a-d /b "%kwPath%"') do echo %%~na

echo.
echo Press any key to return to Help Menu....
echo.
pause>nul

goto helpMain



:end

exit