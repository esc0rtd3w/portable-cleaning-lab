@echo off

title Portable Cleaning Lab - Build Update List - pclupdate.com

color 0a

cd %root%

for /d %%a in (*) do dir /s /b "%%a">%updateListFromTemp%

:: Failsafe if md5CreateToggle fore some reason is not set
::if not defined md5CreateToggle goto end

if %md5CreateToggle%==1 %buildUpdateMD5List%

:end
