@echo off

%cocolor% 0b

"%pclBinPath%\subinacl.exe" /subkeyreg HKEY_LOCAL_MACHINE /grant=administrators=f
"%pclBinPath%\subinacl.exe" /subkeyreg HKEY_CURRENT_USER /grant=administrators=f
"%pclBinPath%\subinacl.exe" /subkeyreg HKEY_CLASSES_ROOT /grant=administrators=f
"%pclBinPath%\subinacl.exe" /subdirectories %SystemDrive% /grant=administrators=f
"%pclBinPath%\subinacl.exe" /subdirectories %windir%\*.* /grant=administrators=f
"%pclBinPath%\subinacl.exe" /subkeyreg HKEY_LOCAL_MACHINE /grant=system=f
"%pclBinPath%\subinacl.exe" /subkeyreg HKEY_CURRENT_USER /grant=system=f
"%pclBinPath%\subinacl.exe" /subkeyreg HKEY_CLASSES_ROOT /grant=system=f
"%pclBinPath%\subinacl.exe" /subdirectories %SystemDrive% /grant=system=f
"%pclBinPath%\subinacl.exe" /subdirectories %windir%\*.* /grant=system=f

:: Setting pwn Commands
set pwnLeft=takeown /f
set pwnRight=/a /r

%pwnLeft% "%systemdrive%" %pwnRight%
%pwnLeft% "%systemdrive%\Windows" %pwnRight%
%pwnLeft% "%systemdrive%\Windows\system32" %pwnRight%

exit