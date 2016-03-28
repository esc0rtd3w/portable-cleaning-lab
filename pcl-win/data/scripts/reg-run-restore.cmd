@echo off

color 0b

:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)


regedit /s "%dumpPath%\run_HKCU.reg"

regedit /s "%dumpPath%\run_HKLM.reg"



:end



exit

