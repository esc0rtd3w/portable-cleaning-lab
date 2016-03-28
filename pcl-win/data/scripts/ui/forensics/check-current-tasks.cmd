@echo off

set tasks="%temp%\pcl\current-tasks.txt"

schtasks /query>%tasks%

%showText% %tasks%


:end

exit

