@echo off

set activeNet="%temp%\pcl\active-network-connections.txt"

netstat>%activeNet%

%showText% %activeNet%


:end

exit

