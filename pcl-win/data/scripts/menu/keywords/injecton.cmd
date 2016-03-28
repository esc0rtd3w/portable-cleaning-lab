@echo off

mode con lines=33

del /f /q "%pclTempMain%\inject.off"
echo injection>"%pclTempMain%\inject.on"

exit

