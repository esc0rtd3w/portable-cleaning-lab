@echo off

color 0a

::echo %openFolder%
::pause

set destination=0
set destName=0


:menuMain
color 0a

title %titleText%

set destination=%systemdrive%\backup

cls
%cocolor% 0f
echo %bannerText%
%cocolor% 0e
echo.
echo Select a folder to backup from below and press ENTER:
echo.
echo.
%cocolor% 0a
echo A) BACKUP ALL BELOW LISTED ITEMS
echo.
echo.
%cocolor% 0e
echo 1) %contacts%
echo.
echo 2) %desktop%
echo.
echo 3) %downloads%
echo.
echo 4) %favorites%
echo.
echo 5) %links%
echo.
echo 6) %documents%
echo.
echo 7) %music%
echo.
echo 8) %pictures%
echo.
echo 9) %videos%
echo.
echo 10) %savedgames%
echo.
echo 11) %searches%
echo.
echo.
%cocolor% 0e
echo B) Go Back
::echo.
::echo X) Exit This Window
echo.
echo.

set /p menuItemBackup=

if [%menuItemBackup%]==[] goto menuMain

if %menuItemBackup%==A goto all
if %menuItemBackup%==a goto all

if %menuItemBackup%==B goto end
if %menuItemBackup%==b goto end

if %menuItemBackup%==X exit
if %menuItemBackup%==x exit

if %menuItemBackup% gtr 11 goto menuMain

if %menuItemBackup%==1 goto option1
if %menuItemBackup%==2 goto option2
if %menuItemBackup%==3 goto option3
if %menuItemBackup%==4 goto option4
if %menuItemBackup%==5 goto option5
if %menuItemBackup%==6 goto option6
if %menuItemBackup%==7 goto option7
if %menuItemBackup%==8 goto option8
if %menuItemBackup%==9 goto option9
if %menuItemBackup%==10 goto option10
if %menuItemBackup%==11 goto option11

goto menuMain

:all

set source=%contacts%
set destDir=%contactsDirName%
call "%~dp0todir.cmd"

set source=%desktop%
set destDir=%desktopDirName%
call "%~dp0todir.cmd"

set source=%downloads%
set destDir=%downloadsDirName%
call "%~dp0todir.cmd"

set source=%favorites%
set destDir=%favoritesDirName%
call "%~dp0todir.cmd"

set source=%links%
set destDir=%linksDirName%
call "%~dp0todir.cmd"

set source=%documents%
set destDir=%mydocumentsDirName%
call "%~dp0todir.cmd"

set source=%mymusic%
set destDir=%mymusicDirName%
call "%~dp0todir.cmd"

set source=%pictures%
set destDir=%mypicturesDirName%
call "%~dp0todir.cmd"

set source=%myvideos%
set destDir=%myvideosDirName%
call "%~dp0todir.cmd"

set source=%savedgames%
set destDir=%savedgamesDirName%
call "%~dp0todir.cmd"

set source=%searches%
set destDir=%searchesDirName%
call "%~dp0todir.cmd"


goto end


:option1

set source=%contacts%
set destDir=%contactsDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option2

set source=%desktop%
set destDir=%desktopDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option3

set source=%downloads%
set destDir=%downloadsDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option4

set source=%favorites%
set destDir=%favoritesDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option5

set source=%links%
set destDir=%linksDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option6

set source=%documents%
set destDir=%mydocumentsDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option7

set source=%mymusic%
set destDir=%mymusicDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option8

::set source=%mypics%
set source=%pictures%
set destDir=%mypicturesDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option9

set source=%myvideos%
set destDir=%myvideosDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option10

set source=%savedgames%
set destDir=%savedgamesDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain

:option11

set source=%searches%
set destDir=%searchesDirName%
goto copyto
::%openFolder% "%destination%\%destDir%\"

goto menuMain



:copyto

set menuItemBackup=1

color 0d

cls
echo Select an output option from below and press ENTER:
echo.
echo.
echo 1) File/Folder Structure
echo.
echo 2) ISO Image*
echo.
echo 3) ZIP File*
echo.
echo 4) RAR File*
echo.
echo 5) 7Z File*
echo.
echo.
echo B) Go Back
echo.
echo.

set /p menuItemBackup=

if [%menuItemBackup%]==[] goto copyto

if %menuItemBackup%==B goto menuMain
if %menuItemBackup%==b goto menuMain

if %menuItemBackup% gtr 5 goto copyto

if %menuItemBackup%==1 call "%~dp0todir.cmd"
if %menuItemBackup%==2 call "%~dp0toiso.cmd"
if %menuItemBackup%==3 call "%~dp0tozip.cmd"
if %menuItemBackup%==4 call "%~dp0torar.cmd"
if %menuItemBackup%==5 call "%~dp0to7z.cmd"

goto menuMain





:end


