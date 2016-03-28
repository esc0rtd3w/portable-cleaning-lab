@echo off

:reset

%checkNetworkStatus%

:: Set menuItem to a high value before displaying each menu
set menuItem=999

set titleText=Utilities :: portablecleaninglab.com
%bannerMenuDefault%

echo Select an option from below and press ENTER:
echo.
echo.
echo 1) Bulk Rename Utility (Mass Rename Files)
echo.
echo 2) Double Driver (Backup and Restore Drivers)
echo.
echo 3) Driver Signature Enforcement Overrider
echo.
echo 4) Linux Reader (ext, ext2, ext3, ext4)
echo.
echo 5) MiniTool Partition Wizard
echo.
echo 6) PowerGREP (Ascii/Binary Search Tool)
echo.
echo 7) Q-Dir (Multi Folder Browser)
echo.
echo 8) RMPrepUSB (Boot USB Preparation Tool)
echo.
echo 9) Super Finder (Search Tool)
echo.
echo 10) Visual BCD (Windows Boot Store Editor)
echo.
echo 11) WIM Converter (Windows Bootable Images)*
echo.
echo 12) Win32 Disk Imager (Raw Write To Media)
::echo 13) Nero (Burning ROM and Express)
echo.
echo.
echo B) Go Back
echo.
echo X) Exit This Window
echo.

set /p menuItem=

if [%menuItem%]==[] goto reset

if %menuItem%==B goto chkExit
if %menuItem%==b goto chkExit

if %menuItem%==X goto chkExit
if %menuItem%==x goto chkExit

if %menuItem% gtr 13 goto reset

if %menuItem%==1 set moduleActive=bulk-rename-utility
if %menuItem%==2 set moduleActive=double-driver
if %menuItem%==3 set moduleActive=dseo
if %menuItem%==4 set moduleActive=linux-reader
if %menuItem%==5 set moduleActive=mtpw
if %menuItem%==6 set moduleActive=power-grep
if %menuItem%==7 set moduleActive=qdir
if %menuItem%==8 set moduleActive=rmprep-usb
if %menuItem%==9 set moduleActive=super-finder
if %menuItem%==10 set moduleActive=visual-bcd
if %menuItem%==11 set moduleActive=wim-converter
if %menuItem%==12 set moduleActive=win32diskimager
if %menuItem%==13 set moduleActive=nero

set runDirectory=%pclTempMain%\%moduleActive%

goto runUtility


:runUtility
cls
echo Unpacking %moduleActive% module....
echo.
echo.

if exist "%pclTempMain%" %rmdir% "%pclTempMain%"
if not exist "%pclTempMain%" %mkdir% "%pclTempMain%"
if not exist "%runDirectory%" %mkdir% "%runDirectory%"

%pclExtractModule% "%pclModulesPath%\utilities\%moduleActive%.pcl" "%pclTempMain%"
call "%pclMenuPath%\utilities\fixes.cmd"
%runShellTerminateAndWait% "%runDirectory%\launch.cmd"

goto reset


:chkExit

if %menuItem%==B set exitStatus=back
if %menuItem%==b set exitStatus=back

if %menuItem%==X set exitStatus=close
if %menuItem%==x set exitStatus=close

:: If an exitStatus is not set then set it to return as default
::if not defined exitStatus set exitStatus=return

::if %exitStatus%==return goto reset

goto end


:end

