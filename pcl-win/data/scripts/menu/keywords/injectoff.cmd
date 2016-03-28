@echo off

mode con lines=33


del /f /q "%pclTempMain%\inject.on"
echo injection>"%pclTempMain%\inject.off"


exit

