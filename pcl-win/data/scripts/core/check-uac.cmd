@echo off


:checkuac
:: Fix false flag for UAC prompt
if %ostype%==xp goto end
if %ostype%==vista %regQueryUacStatusVista% | find "0x0"
if %ostype%==win7 %regQueryUacStatusWin7% | find "0x0"
if %ostype%==win8 %regQueryUacStatusWin8% | find "0x0"
if %ostype%==win81 %regQueryUacStatusWin81% | find "0x0"
if %ostype%==win10 %regQueryUacStatusWin10% | find "0x0"
if %errorlevel%==0 set uacStatus=Disabled
if %errorlevel%==1 set uacStatus=Enabled

::echo %regQueryUacStatusVista%
::pause

if %uacStatus%==Disabled goto end

cls
if %uacStatus%==Enabled %cocolor% 0a
if %uacStatus%==Disabled %cocolor% 0c
echo UAC Status: %uacStatus%
%cocolor% 0f
echo.
echo.
echo UAC (User Account Control) MUST be disabled to continue!
echo.
echo Would you like to do this now? [Y/N]:
echo.
echo.

choice /c yn /n

if errorlevel 2 goto end 
if errorlevel 1 goto disableuac



:disableuac

cls
echo Disabling UAC (User Account Control)....
echo.
echo.
echo 1) Click "YES" on the next dialog box (UAC Prompt).
echo.
echo 2) When UAC Settings open, slide bar to bottom if not already done
echo.
echo 3) Click OK then "YES" on UAC Prompt
echo.
echo.

::if %ostype%==vista %windir%\system32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

start regedit /s "%~dp0data\registry\disableUAC-%ostype%.reg"

if %ostype%==vista goto vistafix
if %ostype%==win7 %windir%\system32\UserAccountControlSettings.exe
if %ostype%==win8 %windir%\system32\UserAccountControlSettings.exe
if %ostype%==win81 %windir%\system32\UserAccountControlSettings.exe
if %ostype%==win10 %windir%\system32\UserAccountControlSettings.exe

%wasteTime%

:: Recheck UAC Status to report proper status
if %ostype%==xp goto end
::if %ostype%==vista %regQueryUacStatusVista%
if %ostype%==win7 %regQueryUacStatusWin7%
if %ostype%==win8 %regQueryUacStatusWin8%
if %ostype%==win81 %regQueryUacStatusWin81%
if %ostype%==win10 %regQueryUacStatusWin10%
if %errorlevel%==0 set uacStatus=Disabled
if %errorlevel%==1 set uacStatus=Enabled
)

if %uacStatus%==Enabled goto checkuac

goto uacReboot



:vistafix

cls
echo VISTA UAC AUTO DISABLE IS NOT WORKING! MUST APPLY MANUALLY!
echo.
echo.
echo Navigate to Control Panel - User Accounts - Turn on or Off
echo.
echo Click "Continue" if a UAC registry prompt appears
echo.
echo Uncheck Box and Click OK
echo.
echo Click "Restart Later" when asked, the PCL will reboot the machine
echo.
echo.
echo Press ENTER to continue....
echo.

set uacStatus=Disabled
pause>nul

goto uacReboot


:uacReboot
cls
if %uacStatus%==Enabled %cocolor% 0a
if %uacStatus%==Disabled %cocolor% 0c
if not %ostype%==vista echo UAC Status: %uacStatus%
if %ostype%==vista echo UAC Status: Manually %uacStatus% By User
%cocolor% 0f
echo.
echo.
echo Would you like to reboot system now? [Y/N]:
echo.
echo.


choice /c yn /n

if errorlevel 2 goto end 
if errorlevel 1 %execFileShutdownRestart%


:end

