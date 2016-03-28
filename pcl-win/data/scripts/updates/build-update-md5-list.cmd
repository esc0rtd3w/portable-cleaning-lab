@echo off

title Portable Cleaning Lab - Build MD5 List For Updates - pclupdate.com

:: REMOVE ALL CODE IN BETWEEN HERE ONCE FIXED -----------------
echo MD5 scripting is currently not working properly!
echo.
echo Skipping in 5 seconds....
echo.
%wait% 5
goto end
:: REMOVE ALL CODE IN BETWEEN HERE ONCE FIXED -----------------


color 0a

:: Start showing GUI for waiting
%busyPopupDefault%
	
setlocal ENABLEDELAYEDEXPANSION

echo.>%updateListFromTemp%
echo.>%updateListMD5TempFromTemp%
echo.>%updateListMD5TempCleanFromTemp%
echo.>%updateListMD5TempClean2FromTemp%
	
set list=%updateListFromTemp%

set processList=0
for /f "tokens=*" %%a in (%list%) do (
    set /a processList=!processList! + 1
	
	cls
    %cocolor% 0f
    echo %bannerText%
    %cocolor% 0e
    echo.
	echo Generating MD5 hashes for all current PCL files, please wait....
	echo.
	
    %md5sum% "%%a">>%updateListMD5TempFromTemp%

)

for /f "delims=" %%a in ('more +1 %updateListMD5TempFromTemp% ^| find /v ""') do (
  cls
  %cocolor% 0f
  echo %bannerText%
  %cocolor% 0e
  echo.
  echo Cleaning Up MD5 List, please wait....
  echo.
	
  set line=%%~a
  set line=!line:"=!
  set line=!line:,=!
  set line=!line:  = !
  set line=!line:=!
  echo !line! | findstr /v "ECHO IS OFF.">>%updateListMD5TempCleanFromTemp%

)

:: Cleanup percent progress text that gets added by md5sums.exe (ex. 12%, 34%, 65%, 100%, etc)
for /f "delims=" %%a in ('more +1 %updateListMD5TempCleanFromTemp% ^| find /v ""') do (
  
  cls
  %cocolor% 0f
  echo %bannerText%
  %cocolor% 0e
  echo.
  echo Cleaning Up MD5 List, please wait....
  echo.
  set line=%%~a
  set line=!line:0%%=!
  set line=!line:1%%=!
  set line=!line:2%%=!
  set line=!line:3%%=!
  set line=!line:4%%=!
  set line=!line:5%%=!
  set line=!line:6%%=!
  set line=!line:7%%=!
  set line=!line:8%%=!
  set line=!line:9%%=!
  set line=!line:10%%=!
  set line=!line:11%%=!
  set line=!line:12%%=!
  set line=!line:13%%=!
  set line=!line:14%%=!
  set line=!line:15%%=!
  set line=!line:16%%=!
  set line=!line:17%%=!
  set line=!line:18%%=!
  set line=!line:19%%=!
  set line=!line:20%%=!
  set line=!line:21%%=!
  set line=!line:22%%=!
  set line=!line:23%%=!
  set line=!line:24%%=!
  set line=!line:25%%=!
  set line=!line:26%%=!
  set line=!line:27%%=!
  set line=!line:28%%=!
  set line=!line:29%%=!
  set line=!line:30%%=!
  set line=!line:31%%=!
  set line=!line:32%%=!
  set line=!line:33%%=!
  set line=!line:34%%=!
  set line=!line:35%%=!
  set line=!line:36%%=!
  set line=!line:37%%=!
  set line=!line:38%%=!
  set line=!line:39%%=!
  set line=!line:40%%=!
  set line=!line:41%%=!
  set line=!line:42%%=!
  set line=!line:43%%=!
  set line=!line:44%%=!
  set line=!line:45%%=!
  set line=!line:46%%=!
  set line=!line:47%%=!
  set line=!line:48%%=!
  set line=!line:49%%=!
  set line=!line:50%%=!
  set line=!line:51%%=!
  set line=!line:52%%=!
  set line=!line:53%%=!
  set line=!line:54%%=!
  set line=!line:55%%=!
  set line=!line:56%%=!
  set line=!line:57%%=!
  set line=!line:58%%=!
  set line=!line:59%%=!
  set line=!line:60%%=!
  set line=!line:61%%=!
  set line=!line:62%%=!
  set line=!line:63%%=!
  set line=!line:64%%=!
  set line=!line:65%%=!
  set line=!line:66%%=!
  set line=!line:67%%=!
  set line=!line:68%%=!
  set line=!line:69%%=!
  set line=!line:70%%=!
  set line=!line:71%%=!
  set line=!line:72%%=!
  set line=!line:73%%=!
  set line=!line:74%%=!
  set line=!line:75%%=!
  set line=!line:76%%=!
  set line=!line:77%%=!
  set line=!line:78%%=!
  set line=!line:79%%=!
  set line=!line:80%%=!
  set line=!line:81%%=!
  set line=!line:82%%=!
  set line=!line:83%%=!
  set line=!line:84%%=!
  set line=!line:85%%=!
  set line=!line:86%%=!
  set line=!line:87%%=!
  set line=!line:88%%=!
  set line=!line:89%%=!
  set line=!line:90%%=!
  set line=!line:91%%=!
  set line=!line:92%%=!
  set line=!line:93%%=!
  set line=!line:94%%=!
  set line=!line:95%%=!
  set line=!line:96%%=!
  set line=!line:97%%=!
  set line=!line:98%%=!
  set line=!line:99%%=!
  set line=!line:100%%=!
  
  echo !line!>>"%localUpdateCache%\updateListMD5TempClean2.txt"
  
)

:: Further cleanup for leftover percent crap
for /f "delims=" %%a in ('more +1 %updateListMD5TempClean2FromTemp% ^| find /v ""') do (
  
  cls
  %cocolor% 0f
  echo %bannerText%
  %cocolor% 0e
  echo.
  echo Cleaning Up MD5 List, please wait....
  echo.
  set line=%%~a
  set line=!line:  =!
  
  echo !line!>>%updateListFromTemp%
  
)

endlocal

:: Close busy popup box
%busyPopupClose%

%copy% %updateListFromTemp% %updateList%
%copy% %updateListMD5FromTemp% %updateListMD5%

%copy% %updateListFromTemp% %localUpdateCache%
%copy% %updateListMD5FromTemp% %localUpdateCache%


%rm% "%pclUpdatesPathTemp%\*"



:end

