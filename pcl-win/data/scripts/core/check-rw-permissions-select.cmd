@echo off

title Portable Cleaning Lab - Check RW Permissions - pclupdate.com

:: Am I a cd?

%cocolor% 0e

set fileAccess=ro

::Write some bs to a temp file.
echo rwcheck>%testFile%

:: If writable, set to rw
if %errorlevel%==0 set fileAccess=rw
del /f /q %testFile%

::echo Test File: %testFile%
::echo File Access: %fileAccess%
::pause

