@echo off

:main
cls
echo Current Source: %source%
echo.
echo Current Destination: %destination%
echo.
echo.
echo.
echo.
echo Enter Destination and Press ENTER:
echo.
echo.
echo.

set /p destination=


::if [%destination%]==[] goto main

::set destination=%destination%


:end


