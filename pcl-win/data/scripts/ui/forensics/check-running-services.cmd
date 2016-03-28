@echo off

set svc="%temp%\pcl\running-services.txt"
set svcExt="%temp%\pcl\running-services-extended.txt"

::net start>%svc%
sc query>%svcExt%

::%showText% %svc%
%showText% %svcExt%

::find "SERVICE_NAME" %svcExt%
::find "DISPLAY_NAME" %svcExt%

::pause


:end

exit

