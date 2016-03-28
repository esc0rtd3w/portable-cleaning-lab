@echo off

echo Portable Cleaning Lab Whitelist Determination>"%temp%\pcl\check-for-whitelist-pf.txt"
echo.>>"%temp%\pcl\check-for-whitelist-pf.txt"
echo PLEASE CHECK THIS FILE FOR ANY BADDIES THAT DO NOT BELONG!!!>>"%temp%\pcl\check-for-whitelist-pf.txt"
echo.>>"%temp%\pcl\check-for-whitelist-pf.txt"
echo.>>"%temp%\pcl\check-for-whitelist-pf.txt"
echo CURRENT PATH: %pf%>>"%temp%\pcl\check-for-whitelist-pf.txt"
echo.>>"%temp%\pcl\check-for-whitelist-pf.txt"
dir /b "%pf%">>"%temp%\pcl\check-for-whitelist-pf.txt"

%showText% "%temp%\pcl\check-for-whitelist-pf.txt"


:end

exit

