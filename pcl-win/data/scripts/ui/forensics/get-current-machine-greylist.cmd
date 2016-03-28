@echo off

echo Portable Cleaning Lab Greylist Determination>"%temp%\pcl\check-for-greylist-pf.txt"
echo.>>"%temp%\pcl\check-for-greylist-pf.txt"
echo PLEASE CHECK FOR ANYTHING THAT DOES NOT FIT BLACK OR WHITE LISTS>>"%temp%\pcl\check-for-greylist-pf.txt"
echo.>>"%temp%\pcl\check-for-greylist-pf.txt"
echo.>>"%temp%\pcl\check-for-greylist-pf.txt"
echo CURRENT PATH: %pf%>>"%temp%\pcl\check-for-greylist-pf.txt"
echo.>>"%temp%\pcl\check-for-greylist-pf.txt"
dir /b "%pf%">>"%temp%\pcl\check-for-greylist-pf.txt"

%showText% "%temp%\pcl\check-for-greylist-pf.txt"


:end

exit

