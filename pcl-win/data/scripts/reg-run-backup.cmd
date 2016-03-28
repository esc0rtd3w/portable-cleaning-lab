@echo off

color 0b

:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)



regedit /e "%dumpPath%\run_HKCU.reg" "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"

regedit /e "%dumpPath%\run_HKLM.reg" "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run"


:end

exit



