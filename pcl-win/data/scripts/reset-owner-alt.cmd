@echo off

%cocolor% 0b

::icacls .\* /setowner %UserDomain%\%UserName% /t
::icacls .\* /reset /t

::cacls .\* /E /T /G %UserName%:F

cacls %systemdrive% /E /T /G %UserName%:F

exit