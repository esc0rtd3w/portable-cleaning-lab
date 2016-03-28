@echo off

mode con lines=33

color 0b

set hostsFile=%windir%\system32\drivers\etc\HOSTS


del /f /q "%hostsFile%"

echo #127.0.0.1 localhost>%hostsFile%

exit

