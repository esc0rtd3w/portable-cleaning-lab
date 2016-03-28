@echo off

title Unlocker Auto Script

set unlock="%pclBinPath%\unlocker.exe"
set unlockdll="%pclBinPath%\UnlockerCOM.dll"
set unlocksys="%pclBinPath%\UnlockerDriver5.sys"

color 0b


:start
set option=99
color 0b
cls
echo Select an option and press ENTER:
echo.
echo.
%cocolor% 0a
echo Type install to install Unlocker to hard drive
echo.
%cocolor% 0c
echo Type uninstall to uninstall Unlocker from hard drive
%cocolor% 0b
echo.
echo.
echo 1) Unlock Only
echo.
echo 2) Unlock and Delete
echo.
echo 3) Add Unlocker To Right-Click Context Menu
echo.
echo 4) Remove Unlocker From Right-Click Context Menu
echo.
echo.

set /p option=

if %option%==install goto hideInst
if %option%==uninstall goto hideUnin

if %option%==1 goto unlock
if %option%==2 goto delete
if %option%==3 goto addrc
if %option%==4 goto delrc

if %option% gtr 4 goto start

goto end


:unlock
cls
echo Mode: Unlock Only
echo.
echo.
echo Drag a folder or file to unlock and press ENTER:
echo.
echo Press M and ENTER to return to main menu
echo.
echo.

set /p target=

if %target%==m goto start
if %target%==M goto start

cls
echo Unlocking
echo.
echo %target%
echo.
echo.

%unlock% "%target%" /s

goto start


:delete
cls
echo Mode: Unlock and Delete
echo.
echo.
echo Drag a folder or file to unlock/delete and press ENTER:
echo.
echo Press M and ENTER to return to main menu
echo.
echo.

set /p target=

if %target%==m goto start
if %target%==M goto start

cls
echo Unlocking/Deleting
echo.
echo %target%
echo.
echo.

%unlock% "%target%" /s /d

goto start


:addrc

regsvr32 /s %unlockdll%

goto start


:delrc

regsvr32 /s /u %unlockdll%

goto start


:hideInst

if %networkStatus%==online goto onlineX
if %networkStatus%==offline goto offlineX

:: Default to online warnings
goto onlineX
::goto end


:onlineX

color 0a

cls
echo This will launch the Unlocker Installer!
echo.
echo If for some reason you are having a hard time using the portable version
echo of Unlocker, then this is another option to get the unlocking on context menu
echo.
echo.
echo BE WARNED THAT YOU MUST DECLINE ALL OFFERS DURING INSTALL!!!!
echo.
echo.
echo 1) CLICK SKIP ON THE FIRST SPECIAL OFFER DIALOG
echo.
echo 2) CLICK SKIP ON THE SECOND SPECIAL OFFER DIALOG
echo.
echo 3) CLICK SKIP ON ANY AND ALL OTHER SPECIAL OFFER DIALOGS
echo.
echo.
echo The PCL was meant to clean the exact crap that this installer gives you!
echo.
echo.
echo PRESS ENTER TO CONTINUE....
echo.
echo.

pause>nul

"%pclBinPath%\UnlockerInstall.exe"

goto start


:offlineX

color 0a

cls
echo This will launch the Unlocker Installer!
echo.
echo If for some reason you are having a hard time using the portable version
echo of Unlocker, then this is another option to get the unlocking on context menu
echo.
echo.
echo BE WARNED THAT YOU MUST DECLINE ALL OFFERS DURING INSTALL, IF PRESENT!!!!
echo.
echo.
echo The PCL was meant to clean the exact crap that this installer gives you!
echo.
echo.
echo PRESS ENTER TO CONTINUE....
echo.
echo.

pause>nul

"%pclBinPath%\UnlockerInstall.exe"

goto start


:hideUnin

cls
echo Launching Unlocker Uninstaller....
echo.
echo.

"C:\Program Files\Unlocker\uninst.exe"

goto start



:end

