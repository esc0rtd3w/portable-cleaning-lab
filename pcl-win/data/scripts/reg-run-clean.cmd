@echo off

color 0b

:: 32-bit fix
if not defined ProgramFiles(x86) set ProgramFiles(x86)=%systemdrive%\Program Files (x86)


reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f /va

reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /f /va



:end

exit




