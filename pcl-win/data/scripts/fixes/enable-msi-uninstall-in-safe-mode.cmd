@echo off


reg add “HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer” /ve /t REG_SZ /f /d “Service”

net start msiserver

