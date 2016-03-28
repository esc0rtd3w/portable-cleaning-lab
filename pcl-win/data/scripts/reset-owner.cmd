@echo off

%cocolor% 0b

::icacls .\* /setowner %UserDomain%\%UserName% /t
::icacls .\* /reset /t


icacls %systemdrive% /setowner %UserDomain%\%UserName% /t
icacls %systemdrive% /reset /t

exit