@echo off

color 0b

set interface="Wireless Network Connection"

cls
echo Disconnecting From %interface%....
echo.
netsh wlan disconnect

cls
echo Disabling %interface%....
echo.
netsh interface set interface name=%interface% admin=disabled

cls
echo Enabling %interface%....
echo.
netsh interface set interface name=%interface% admin=enabled