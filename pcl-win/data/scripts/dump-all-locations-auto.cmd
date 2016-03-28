@echo off

title Dumping All Known Malware Locations From Registry


color 0d

if not exist "%pclDumpPathLocalRegistry%" md "%pclDumpPathLocalRegistry%"


:: Run Locations

cls
echo Dumping Run Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKCU\Software\Microsoft\Windows\CurrentVersion\Run
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\run_HKCU.reg" "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"


cls
echo Dumping Run Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\Software\Microsoft\Windows\CurrentVersion\Run
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\run_HKLM.reg" "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run"


cls
echo Dumping Run Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKU\.Default\Software\Microsoft\Windows\CurrentVersion\Run
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\run_HKU.reg" "HKEY_USERS\.Default\Software\Microsoft\Windows\CurrentVersion\Run"


cls
echo Dumping Run Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\run
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\run_HKCU_CV_PER.reg" "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\run"


cls
echo Dumping Run Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\run
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\run_HKLM_CV_PER.reg" "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\run"


cls
echo Dumping Run Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\run
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\run_HKLM_CV_PER.reg" "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows\run"



:: RunOnce Locations

cls
echo Dumping RunOnce Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\runOnce_HKCU.reg" "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce"


cls
echo Dumping RunOnce Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\runOnce_HKLM.reg" "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce"


cls
echo Dumping RunOnce Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKU\.Default\Software\Microsoft\Windows\CurrentVersion\RunOnce
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\runOnce_HKU.reg" "HKEY_USERS\.Default\Software\Microsoft\Windows\CurrentVersion\RunOnce"



:: RunServices Locations


cls
echo Dumping RunServices Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\runServices_HKCU.reg" "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunServices"



:: RunServicesOnce Locations


cls
echo Dumping RunServicesOnce Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\runServicesOnce_HKCU.reg" "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce"


:: Other Autorun Locations

cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\load
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\misc_HKCU_NT_CV.reg" "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows\load"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\Software\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\misc_HKLM_CV_SSOD.reg" "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\System\Control\WOW\wowcmdline
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\misc_HKLM_WOWCMD1.reg" "HKEY_LOCAL_MACHINE\System\Control\WOW\wowcmdline"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\System\Control\WOW\cmdline
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\misc_HKLM_WOWCMD2.reg" "HKEY_LOCAL_MACHINE\System\Control\WOW\cmdline"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\System\CurrentControlSet\Services\Winsock2\Parameters\Protocol_Catalog\Catalog_Entries
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\misc_HKLM_CC_CE.reg" "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Winsock2\Parameters\Protocol_Catalog\Catalog_Entries"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\System\CurrentControlSet\Services
echo.
echo.

:: Skipping because of large filesize 20140809
::regedit /e "%pclDumpPathLocalRegistry%\misc_HKLM_CC_SVC.reg" "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\System\CurrentControlSet\Control\Session Manager
echo.
echo.

:: Skipping because of large filesize 20140809
::regedit /e "%pclDumpPathLocalRegistry%\misc_HKLM_CCS_CSM.reg" "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKCU\Control Panel\Desktop
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\misc_HKCU_CP_DESK.reg" "HKEY_CURRENT_USER\Control Panel\Desktop"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\System\CurrentControlSet\Services\VxD
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\misc_HKCU_CCS_VXD.reg" "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\Software\Microsoft\Active Setup\Installed Components
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\misc_HKCU_MS_AS_IC.reg" "HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components"



cls
echo Dumping Other Autorun Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\misc_HKCU_NT_CV_WL.reg" "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"



:: Uninstall Locations

cls
echo Dumping Uninstall Locations From Registry....
echo.
echo.
echo Save Location: %pclDumpPathLocalRegistry%
echo.
echo Key: HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall
echo.
echo.

regedit /e "%pclDumpPathLocalRegistry%\uninstall_HKLM.reg" "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall"


cls
exit

