@echo off

echo Portable Cleaning Lab Blacklist Determination>"%temp%\pcl\check-for-blacklist-pf.txt"
echo.>>"%temp%\pcl\check-for-blacklist-pf.txt"
echo PLEASE CHECK THIS FILE FOR ANY GOOD GUYS THAT DO NOT BELONG!!!>>"%temp%\pcl\check-for-blacklist-pf.txt"
echo.>>"%temp%\pcl\check-for-blacklist-pf.txt"
echo.>>"%temp%\pcl\check-for-blacklist-pf.txt"
echo CURRENT PATH: %pf%>>"%temp%\pcl\check-for-blacklist-pf.txt"
echo.>>"%temp%\pcl\check-for-blacklist-pf.txt"
dir /b "%pf%">>"%temp%\pcl\check-for-blacklist-pf.txt"

%showText% "%temp%\pcl\check-for-blacklist-pf.txt"


:end

exit

