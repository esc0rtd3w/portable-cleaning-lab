@echo off

::MsiExec.exe /passive /X{0CD47142-BA4F-46B0-AA92-2675864928B8}

"C:\Program Files\Microsoft Security Client\Setup.exe" /x /u /s

taskkill /f /im MsMpEng.exe
taskkill /f /im msseces.exe

net stop MsMpSvc
sc delete MsMpSvc

reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\MsMpSvc" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Antimalware" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Security Client" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Microsoft Antimalware" /f
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\Current Version\Run\MSC" /f
reg delete "HKEY_CLASSES_ROOT\Installer\Products\4C677A77F01DD614880F352F9DCD9D3B" /f
reg delete "HKEY_CLASSES_ROOT\Installer\Products\4D880477777087D409D44E533B815F2D" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Security Client" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{774088D4-0777-4D78-904D-E435B318F5D2}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{77A776C4-D10F-416D-88F0-53F2D9DCD9B3}" /f
reg delete "HKEY_CLASSES_ROOT\Installer\UpgradeCodes\1F69ACF0D1CF2B7418F292F0E05EC20B" /f
reg delete "HKEY_CLASSES_ROOT\Installer\UpgradeCodes\11BB99F8B7FD53D4398442FBBAEF050F" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\4C677A77F01DD614880F352F9DCD9D3B" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\4D880477777087D409D44E533B815F2D" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UpgradeCodes\11BB99F8B7FD53D4398442FBBAEF050F" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UpgradeCodes\1F69ACF0D1CF2B7418F292F0E05EC20B" /f

takeown /f "%ProgramData%\Microsoft\Microsoft Antimalware" /a /r
takeown /f "%ProgramData%\Microsoft\Microsoft Security Client" /a /r
takeown /f "%ProgramFiles%\Microsoft Security Client" /a /r

rmdir /s /q "%ProgramData%\Microsoft\Microsoft Antimalware"
rmdir /s /q "%ProgramData%\Microsoft\Microsoft Security Client"
rmdir /s /q "%ProgramFiles%\Microsoft Security Client"

sc stop sharedaccess
sc stop mpssvc
sc stop wscsvc
sc stop iphlpsvc
sc stop winmgmt

rmdir /s /q "C:\Windows\System32\wbem\Repository"

sc stop

:end

