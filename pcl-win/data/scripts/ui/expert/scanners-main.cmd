@echo off

:reset

::%checkNetworkStatus%

:: Clean last PCL module before showing menu
:: Action does not happen if moduleActive has not yet been defined (a module has not been launched this session)
if defined moduleActive (
%rmsub% "%pclTempMain%\%moduleActive%"
%rmdir% "%pclTempMain%\%moduleActive%"
)

:: Set menuItem to a high value before displaying each menu
set menuItem=999

:: Close Inject Window if loaded 20140809
%closeActiveWindowByTitle% "Portable Cleaning Lab Module Inject"

:: Avast Temp Fix Part 1 - Added 20140727
set avastFix=0

set doubleLaunchFix=0

set globalActive=scanners

set titleText=Malware and Virus Scanners :: portablecleaninglab.com

%bannerMenuDefault%

if %inject%==0 %cocolor% 0c
if %inject%==1 %cocolor% 0a
echo Module Inject Status: [%injectStatus%]
echo.

if exist "%pclTempMain%\scannerUpdateMode.default" set scannerUpdateMode=default
if exist "%pclTempMain%\scannerUpdateMode.multi" set scannerUpdateMode=multi
if %scannerUpdateMode%==default %cocolor% 08
if %scannerUpdateMode%==multi %cocolor% 0b
::echo Update Mode: [%scannerUpdateMode%]
::echo.

%cocolor% 0e
echo Select an option from below and press ENTER:
echo.
echo 1) 360 Total Security***
echo 2) AntiVir*
echo 3) Avast awsMBR
echo 4) AVG Antivirus***
echo 5) BitDefender
echo 6) ClamWin
echo 7) Comodo Cleaning Essentials
echo 8) Dr Web: CureIt
echo 9) Emsisoft Antivirus
echo 10) ESET NOD32 Antivirus*
echo 11) F-Prot Antivirus
echo 12) Kaspersky Virus Scanner*
echo 13) Malwarebytes Anti-Malware
echo 14) Malware Destroyer
echo 15) McAfee Stinger
echo 16) McAfee VirusScan
echo 17) Microsoft Security Essentials***
echo 18) Norman Malware Cleaner***
echo 19) Panda Antivirus
echo 20) RemoveIT Pro v4: SE
echo 21) SuperAntiSpyware
echo 22) Sophos Virus Removal Tool
echo 23) Spybot: Search and Destroy
echo 24) Trend Micro SysClean*
echo 25) VBA32 Antivirus
echo 26) Vipre Rescue Scanner*
echo 27) Zillya Antivirus
echo.
echo.
%cocolor% 0e
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

if %menuItem% gtr 27 goto reset


if %menuItem%==1 set moduleActive=360tse
if %menuItem%==2 set moduleActive=antivir
if %menuItem%==3 set moduleActive=avast
if %menuItem%==4 set moduleActive=avg
if %menuItem%==5 set moduleActive=bitdefender
if %menuItem%==6 set moduleActive=clamwin
if %menuItem%==7 set moduleActive=comodo
if %menuItem%==8 set moduleActive=drweb
::if %menuItem%==6 set moduleActive=disabled
if %menuItem%==9 set moduleActive=emsisoft
if %menuItem%==10 set moduleActive=eset
if %menuItem%==11 set moduleActive=fprot
::if %menuItem%==10 set moduleActive=kaspersky
if %menuItem%==12 set moduleActive=disabled
if %menuItem%==13 set moduleActive=malwarebytes
if %menuItem%==14 set moduleActive=malware-destroyer
if %menuItem%==15 set moduleActive=mcafee-stinger
if %menuItem%==16 set moduleActive=mcafee-virus-scan
if %menuItem%==17 set moduleActive=mse
::if %menuItem%==15 set moduleActive=norman
if %menuItem%==18 set moduleActive=disabled
if %menuItem%==19 set moduleActive=panda
if %menuItem%==20 set moduleActive=removeit
if %menuItem%==21 set moduleActive=sas
if %menuItem%==22 set moduleActive=sophos
if %menuItem%==23 set moduleActive=spybot
if %menuItem%==24 set moduleActive=trend-micro
if %menuItem%==25 set moduleActive=vba32
if %menuItem%==26 set moduleActive=vipre
if %menuItem%==27 set moduleActive=zillya
:: Malwarebytes Classic Updates Have Went Offline Since 03/2016
::if %menuItem%==28 set moduleActive=malwarebytes-classic

:: Check for 0 value of activeModule
if %moduleActive%==0 goto reset

:: If module has problems or is not working correctly, set type to "disabled"
if %moduleActive%==disabled %msgBox% "There are problems with this module and it has been temporarily DISABLED!" "Disabled Module"
if %moduleActive%==disabled goto reset

%processActiveModule%

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


