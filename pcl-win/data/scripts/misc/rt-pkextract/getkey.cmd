@echo off


"%SystemRoot%\System32\reg.exe" query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId | cscript //nologo //e:vbscript "%~f0"

pause