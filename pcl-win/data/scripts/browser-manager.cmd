@echo off

mode con lines=29

set kill=taskkill /f /im

set pf=%systemdrive%\Program Files
set pf64=%systemdrive%\Program Files (x86)

set browserAvant=Avant Browser\avant.exe
set browserChrome=Google\Chrome\Application\chrome.exe
set browserComodoDragon=Comodo\Dragon\dragon.exe
set browserComodoIceDragon=Comodo\IceDragon\icedragon.exe
set browserFirefox=Mozilla Firefox\firefox.exe
set browserFlock=Flock\flock.exe
set browserKMeleon=K-Meleon\k-meleon.exe
set browserMaxthon=Maxthon\Bin\Maxthon.exe
set browserNetscape=Netscape\Navigator 9\navigator.exe
set browserNetscape6=Netscape\Navigator 6\navigator.exe
set browserNetscape7=Netscape\Navigator 7\navigator.exe
set browserNetscape8=Netscape\Navigator 8\navigator.exe
set browserNetscape9=Netscape\Navigator 9\navigator.exe
set browserOpera=Opera\opera.exe
set browserSafari=Opera\safari.exe
set browserSeaMonkey=SeaMonkey\seamonkey.exe
set browserTorch=Torch\torch.exe

color 0b

title Portable Cleaning Lab Web Browser Manager - portablecleaninglab.com


:menuMain
cls
%cocolor% 0c
echo ATTENTION! SOME OPTIONS HERE DO NOT WORK CORRECTLY!
%cocolor% 0b
echo.
echo.
echo Select an option from below and press ENTER:
echo.
echo.
echo.
echo 1) List All Available Browsers
echo.
echo 2) Backup and Restore Settings, Bookmarks, and Other Data
echo.
echo 3) Set a Specific Web Browser As Default
echo.
echo 4) Select a Web Browser To Open
echo.
echo 5) Select a Web Browser To Close
echo.
echo 6) Select Addons and Toolbars To Remove
echo.
echo 7) Select Web Browsers To Remove
echo.
echo 8) Other Browser Tweaks and Fixes
echo.
echo.
echo X) Exit This Window
echo.

set /p getInput=


if [%getInput%]==[] goto menuMain

::if %getInput%==W %runShellNoTerminate% "%pclScriptsPath%\.cmd"
::if %getInput%==w %runShellNoTerminate% "%pclScriptsPath%\.cmd"

if %getInput%==X goto end
if %getInput%==x goto end

if %getInput% gtr 8 goto menuMain

if %getInput%==1 goto opt1
if %getInput%==2 goto opt2
if %getInput%==3 goto opt3
if %getInput%==4 goto opt4
if %getInput%==5 goto opt5
if %getInput%==6 goto opt6
if %getInput%==7 goto opt7
if %getInput%==8 goto opt8


:opt1

set getInput=999

cls
echo List of Installed Web Browsers:
echo.
echo.
%cocolor% 0b
if exist "%pf%\%browserAvant%" %cocolor% 0a
if exist "%pf64%\%browserAvant%" %cocolor% 0a
echo 1) Avant
%cocolor% 0b
if exist "%pf%\%browserChrome%" %cocolor% 0a
if exist "%pf64%\%browserChrome%" %cocolor% 0a
echo 2) Chrome
%cocolor% 0b
if exist "%pf%\%browserComodoDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoDragon%" %cocolor% 0a
echo 3) Comodo Dragon
%cocolor% 0b
if exist "%pf%\%browserComodoIceDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoIceDragon%" %cocolor% 0a
echo 4) Comodo Ice Dragon
%cocolor% 0b
if exist "%pf%\%browserFirefox%" %cocolor% 0a
if exist "%pf64%\%browserFirefox%" %cocolor% 0a
echo 5) Firefox
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 6) Flock
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 7) Internet Explorer
%cocolor% 0b
if exist "%pf%\%browserKmeleon%" %cocolor% 0a
if exist "%pf64%\%browserKmeleon%" %cocolor% 0a
echo 8) K-meleon
%cocolor% 0b
if exist "%pf%\%browserMaxthon%" %cocolor% 0a
if exist "%pf64%\%browserMaxthon%" %cocolor% 0a
echo 9) Maxthon
%cocolor% 0b
if exist "%pf%\%browserNetscape%" %cocolor% 0a
if exist "%pf64%\%browserNetscape%" %cocolor% 0a
echo 10) Netscape
%cocolor% 0b
if exist "%pf%\%browserOpera%" %cocolor% 0a
if exist "%pf64%\%browserOpera%" %cocolor% 0a
echo 11) Opera
%cocolor% 0b
if exist "%pf%\%browserSafari%" %cocolor% 0a
if exist "%pf64%\%browserSafari%" %cocolor% 0a
echo 12) Safari
%cocolor% 0b
if exist "%pf%\%browserSeaMonkey%" %cocolor% 0a
if exist "%pf64%\%browserSeaMonkey%" %cocolor% 0a
echo 13) Seamonkey
%cocolor% 0b
if exist "%pf%\%browserTorch%" %cocolor% 0a
if exist "%pf64%\%browserTorch%" %cocolor% 0a
echo 14) Torch
%cocolor% 0b
echo.
echo.
echo B) Back To Main Browser Menu
echo.
echo X) Exit This Window
echo.

set /p getInput=


if [%getInput%]==[] goto opt1

if %getInput%==B goto menuMain
if %getInput%==b goto menuMain

if %getInput%==X goto end
if %getInput%==x goto end

if %getInput% gtr 14 goto opt1

if %getInput%==1 goto opt1
if %getInput%==2 goto opt1
if %getInput%==3 goto opt1
if %getInput%==4 goto opt1
if %getInput%==5 goto opt1
if %getInput%==6 goto opt1
if %getInput%==7 goto opt1
if %getInput%==8 goto opt1
if %getInput%==9 goto opt1
if %getInput%==10 goto opt1
if %getInput%==11 goto opt1
if %getInput%==12 goto opt1
if %getInput%==13 goto opt1
if %getInput%==14 goto opt1

goto opt1


:opt2


set getInput=999

cls
echo Select a browser and press ENTER:
echo.
echo.
%cocolor% 0b
if exist "%pf%\%browserAvant%" %cocolor% 0a
if exist "%pf64%\%browserAvant%" %cocolor% 0a
echo 1) Avant
%cocolor% 0b
if exist "%pf%\%browserChrome%" %cocolor% 0a
if exist "%pf64%\%browserChrome%" %cocolor% 0a
echo 2) Chrome
%cocolor% 0b
if exist "%pf%\%browserComodoDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoDragon%" %cocolor% 0a
echo 3) Comodo Dragon
%cocolor% 0b
if exist "%pf%\%browserComodoIceDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoIceDragon%" %cocolor% 0a
echo 4) Comodo Ice Dragon
%cocolor% 0b
if exist "%pf%\%browserFirefox%" %cocolor% 0a
if exist "%pf64%\%browserFirefox%" %cocolor% 0a
echo 5) Firefox
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 6) Flock
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 7) Internet Explorer
%cocolor% 0b
if exist "%pf%\%browserKmeleon%" %cocolor% 0a
if exist "%pf64%\%browserKmeleon%" %cocolor% 0a
echo 8) K-meleon
%cocolor% 0b
if exist "%pf%\%browserMaxthon%" %cocolor% 0a
if exist "%pf64%\%browserMaxthon%" %cocolor% 0a
echo 9) Maxthon
%cocolor% 0b
if exist "%pf%\%browserNetscape%" %cocolor% 0a
if exist "%pf64%\%browserNetscape%" %cocolor% 0a
echo 10) Netscape
%cocolor% 0b
if exist "%pf%\%browserOpera%" %cocolor% 0a
if exist "%pf64%\%browserOpera%" %cocolor% 0a
echo 11) Opera
%cocolor% 0b
if exist "%pf%\%browserSafari%" %cocolor% 0a
if exist "%pf64%\%browserSafari%" %cocolor% 0a
echo 12) Safari
%cocolor% 0b
if exist "%pf%\%browserSeaMonkey%" %cocolor% 0a
if exist "%pf64%\%browserSeaMonkey%" %cocolor% 0a
echo 13) Seamonkey
%cocolor% 0b
if exist "%pf%\%browserTorch%" %cocolor% 0a
if exist "%pf64%\%browserTorch%" %cocolor% 0a
echo 14) Torch
%cocolor% 0b
echo.
echo.
echo B) Back To Main Browser Menu
echo.
echo X) Exit This Window
echo.

set /p getInput=


if [%getInput%]==[] goto opt7

if %getInput%==B goto menuMain
if %getInput%==b goto menuMain

if %getInput%==X goto end
if %getInput%==x goto end

if %getInput% gtr 14 goto opt7

if %getInput%==1 call "%pclScriptsPath%\uninstall\browsers\avant.cmd"
if %getInput%==2 call "%pclScriptsPath%\uninstall\browsers\chrome.cmd"
if %getInput%==3 call "%pclScriptsPath%\uninstall\browsers\comodo-dragon.cmd"
if %getInput%==4 call "%pclScriptsPath%\uninstall\browsers\comodo-ice-dragon.cmd"
if %getInput%==5 call "%pclScriptsPath%\uninstall\browsers\firefox.cmd"
if %getInput%==6 call "%pclScriptsPath%\uninstall\browsers\flock.cmd"
if %getInput%==7 call "%pclScriptsPath%\uninstall\browsers\ie.cmd"
if %getInput%==8 call "%pclScriptsPath%\uninstall\browsers\kmeleon.cmd"
if %getInput%==9 call "%pclScriptsPath%\uninstall\browsers\maxthon.cmd"
if %getInput%==10 call "%pclScriptsPath%\uninstall\browsers\netscape.cmd"
if %getInput%==11 call "%pclScriptsPath%\uninstall\browsers\opera.cmd"
if %getInput%==12 call "%pclScriptsPath%\uninstall\browsers\safari.cmd"
if %getInput%==13 call "%pclScriptsPath%\uninstall\browsers\seamonkey.cmd"
if %getInput%==14 call "%pclScriptsPath%\uninstall\browsers\torch.cmd"

goto opt2


:opt3


set getInput=999

cls
echo Select a browser to set as DEFAULT and press ENTER:
echo.
echo.
%cocolor% 0b
if exist "%pf%\%browserAvant%" %cocolor% 0a
if exist "%pf64%\%browserAvant%" %cocolor% 0a
echo 1) Avant
%cocolor% 0b
if exist "%pf%\%browserChrome%" %cocolor% 0a
if exist "%pf64%\%browserChrome%" %cocolor% 0a
echo 2) Chrome
%cocolor% 0b
if exist "%pf%\%browserComodoDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoDragon%" %cocolor% 0a
echo 3) Comodo Dragon
%cocolor% 0b
if exist "%pf%\%browserComodoIceDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoIceDragon%" %cocolor% 0a
echo 4) Comodo Ice Dragon
%cocolor% 0b
if exist "%pf%\%browserFirefox%" %cocolor% 0a
if exist "%pf64%\%browserFirefox%" %cocolor% 0a
echo 5) Firefox
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 6) Flock
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 7) Internet Explorer
%cocolor% 0b
if exist "%pf%\%browserKmeleon%" %cocolor% 0a
if exist "%pf64%\%browserKmeleon%" %cocolor% 0a
echo 8) K-meleon
%cocolor% 0b
if exist "%pf%\%browserMaxthon%" %cocolor% 0a
if exist "%pf64%\%browserMaxthon%" %cocolor% 0a
echo 9) Maxthon
%cocolor% 0b
if exist "%pf%\%browserNetscape%" %cocolor% 0a
if exist "%pf64%\%browserNetscape%" %cocolor% 0a
echo 10) Netscape
%cocolor% 0b
if exist "%pf%\%browserOpera%" %cocolor% 0a
if exist "%pf64%\%browserOpera%" %cocolor% 0a
echo 11) Opera
%cocolor% 0b
if exist "%pf%\%browserSafari%" %cocolor% 0a
if exist "%pf64%\%browserSafari%" %cocolor% 0a
echo 12) Safari
%cocolor% 0b
if exist "%pf%\%browserSeaMonkey%" %cocolor% 0a
if exist "%pf64%\%browserSeaMonkey%" %cocolor% 0a
echo 13) Seamonkey
%cocolor% 0b
if exist "%pf%\%browserTorch%" %cocolor% 0a
if exist "%pf64%\%browserTorch%" %cocolor% 0a
echo 14) Torch
%cocolor% 0b
echo.
echo.
echo B) Back To Main Browser Menu
echo.
echo X) Exit This Window
echo.

set /p getInput=


if [%getInput%]==[] goto opt3

if %getInput%==B goto menuMain
if %getInput%==b goto menuMain

if %getInput%==X goto end
if %getInput%==x goto end

if %getInput% gtr 14 goto opt3

if %getInput%==1 regedit /s "%pclRegistryPath%\default-browser-avant-win7.reg"
if %getInput%==2 regedit /s "%pclRegistryPath%\default-browser-chrome-win7.reg"
if %getInput%==3 regedit /s "%pclRegistryPath%\default-browser-dragon-win7.reg"
if %getInput%==4 regedit /s "%pclRegistryPath%\default-browser-icedragon-win7.reg"
if %getInput%==5 regedit /s "%pclRegistryPath%\default-browser-firefox-win7.reg"
if %getInput%==6 regedit /s "%pclRegistryPath%\default-browser-flock-win7.reg"
if %getInput%==7 regedit /s "%pclRegistryPath%\default-browser-ie-win7.reg"
if %getInput%==8 regedit /s "%pclRegistryPath%\default-browser-kmeleon-win7.reg"
if %getInput%==9 regedit /s "%pclRegistryPath%\default-browser-maxthon-win7.reg"
if %getInput%==10 regedit /s "%pclRegistryPath%\default-browser-netscape-win7.reg"
if %getInput%==11 regedit /s "%pclRegistryPath%\default-browser-opera-win7.reg"
if %getInput%==12 regedit /s "%pclRegistryPath%\default-browser-safari-win7.reg"
if %getInput%==13 regedit /s "%pclRegistryPath%\default-browser-seamonkey-win7.reg"
if %getInput%==14 regedit /s "%pclRegistryPath%\default-browser-torch-win7.reg"

goto opt3


:opt4


set getInput=999

cls
echo Select a browser to OPEN and press ENTER:
echo.
echo.
%cocolor% 0b
if exist "%pf%\%browserAvant%" %cocolor% 0a
if exist "%pf64%\%browserAvant%" %cocolor% 0a
echo 1) Avant
%cocolor% 0b
if exist "%pf%\%browserChrome%" %cocolor% 0a
if exist "%pf64%\%browserChrome%" %cocolor% 0a
echo 2) Chrome
%cocolor% 0b
if exist "%pf%\%browserComodoDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoDragon%" %cocolor% 0a
echo 3) Comodo Dragon
%cocolor% 0b
if exist "%pf%\%browserComodoIceDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoIceDragon%" %cocolor% 0a
echo 4) Comodo Ice Dragon
%cocolor% 0b
if exist "%pf%\%browserFirefox%" %cocolor% 0a
if exist "%pf64%\%browserFirefox%" %cocolor% 0a
echo 5) Firefox
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 6) Flock
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 7) Internet Explorer
%cocolor% 0b
if exist "%pf%\%browserKmeleon%" %cocolor% 0a
if exist "%pf64%\%browserKmeleon%" %cocolor% 0a
echo 8) K-meleon
%cocolor% 0b
if exist "%pf%\%browserMaxthon%" %cocolor% 0a
if exist "%pf64%\%browserMaxthon%" %cocolor% 0a
echo 9) Maxthon
%cocolor% 0b
if exist "%pf%\%browserNetscape%" %cocolor% 0a
if exist "%pf64%\%browserNetscape%" %cocolor% 0a
echo 10) Netscape
%cocolor% 0b
if exist "%pf%\%browserOpera%" %cocolor% 0a
if exist "%pf64%\%browserOpera%" %cocolor% 0a
echo 11) Opera
%cocolor% 0b
if exist "%pf%\%browserSafari%" %cocolor% 0a
if exist "%pf64%\%browserSafari%" %cocolor% 0a
echo 12) Safari
%cocolor% 0b
if exist "%pf%\%browserSeaMonkey%" %cocolor% 0a
if exist "%pf64%\%browserSeaMonkey%" %cocolor% 0a
echo 13) Seamonkey
%cocolor% 0b
if exist "%pf%\%browserTorch%" %cocolor% 0a
if exist "%pf64%\%browserTorch%" %cocolor% 0a
echo 14) Torch
%cocolor% 0b
echo.
echo.
echo B) Back To Main Browser Menu
echo.
echo X) Exit This Window
echo.

set /p getInput=


if [%getInput%]==[] goto opt4

if %getInput%==B goto menuMain
if %getInput%==b goto menuMain

if %getInput%==X goto end
if %getInput%==x goto end

if %getInput% gtr 14 goto opt4

if %getInput%==1 (
%runShellNoTerminate% "%pf%\%browserAvant%"
%runShellNoTerminate% "%pf64%\%browserAvant%"
)

if %getInput%==2 (
%runShellNoTerminate% "%pf%\%browserChrome%"
%runShellNoTerminate% "%pf64%\%browserChrome%"
)

if %getInput%==3 (
%runShellNoTerminate% "%pf%\%browserComodoDragon%"
%runShellNoTerminate% "%pf64%\%browserComodoDragon%"
)

if %getInput%==4 (
%runShellNoTerminate% "%pf%\%browserComodoIceDragon%"
%runShellNoTerminate% "%pf64%\%browserComodoIceDragon%"
)

if %getInput%==5 (
%runShellNoTerminate% "%pf%\%browserFirefox%"
%runShellNoTerminate% "%pf64%\%browserFirefox%"
)

if %getInput%==6 (
%runShellNoTerminate% "%pf%\%browserFlock%"
%runShellNoTerminate% "%pf64%\%browserFlock%"
)

if %getInput%==7 (
%runShellNoTerminate% "%pf%\%browserIE%"
%runShellNoTerminate% "%pf64%\%browserIE%"
)

if %getInput%==8 (
%runShellNoTerminate% "%pf%\%browserKmeleon%"
%runShellNoTerminate% "%pf64%\%browserKmeleon%"
)

if %getInput%==9 (
%runShellNoTerminate% "%pf%\%browserMaxthon%"
%runShellNoTerminate% "%pf64%\%browserMaxthon%"
)

if %getInput%==10 (
%runShellNoTerminate% "%pf%\%browserNetscape%"
%runShellNoTerminate% "%pf64%\%browserNetscape%"
)

if %getInput%==11 (
%runShellNoTerminate% "%pf%\%browserOpera%"
%runShellNoTerminate% "%pf64%\%browserOpera%"
)

if %getInput%==12 (
%runShellNoTerminate% "%pf%\%browserSafari%"
%runShellNoTerminate% "%pf64%\%browserSafari%"
)

if %getInput%==13 (
%runShellNoTerminate% "%pf%\%browserSeaMonkey%"
%runShellNoTerminate% "%pf64%\%browserSeaMonkey%"
)

if %getInput%==14 (
%runShellNoTerminate% "%pf%\%browserTorch%"
%runShellNoTerminate% "%pf64%\%browserTorch%"
)

goto opt4


:opt5


set getInput=999

cls
echo Select a browser to CLOSE and press ENTER:
echo.
echo.
%cocolor% 0b
if exist "%pf%\%browserAvant%" %cocolor% 0a
if exist "%pf64%\%browserAvant%" %cocolor% 0a
echo 1) Avant
%cocolor% 0b
if exist "%pf%\%browserChrome%" %cocolor% 0a
if exist "%pf64%\%browserChrome%" %cocolor% 0a
echo 2) Chrome
%cocolor% 0b
if exist "%pf%\%browserComodoDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoDragon%" %cocolor% 0a
echo 3) Comodo Dragon
%cocolor% 0b
if exist "%pf%\%browserComodoIceDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoIceDragon%" %cocolor% 0a
echo 4) Comodo Ice Dragon
%cocolor% 0b
if exist "%pf%\%browserFirefox%" %cocolor% 0a
if exist "%pf64%\%browserFirefox%" %cocolor% 0a
echo 5) Firefox
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 6) Flock
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 7) Internet Explorer
%cocolor% 0b
if exist "%pf%\%browserKmeleon%" %cocolor% 0a
if exist "%pf64%\%browserKmeleon%" %cocolor% 0a
echo 8) K-meleon
%cocolor% 0b
if exist "%pf%\%browserMaxthon%" %cocolor% 0a
if exist "%pf64%\%browserMaxthon%" %cocolor% 0a
echo 9) Maxthon
%cocolor% 0b
if exist "%pf%\%browserNetscape%" %cocolor% 0a
if exist "%pf64%\%browserNetscape%" %cocolor% 0a
echo 10) Netscape
%cocolor% 0b
if exist "%pf%\%browserOpera%" %cocolor% 0a
if exist "%pf64%\%browserOpera%" %cocolor% 0a
echo 11) Opera
%cocolor% 0b
if exist "%pf%\%browserSafari%" %cocolor% 0a
if exist "%pf64%\%browserSafari%" %cocolor% 0a
echo 12) Safari
%cocolor% 0b
if exist "%pf%\%browserSeaMonkey%" %cocolor% 0a
if exist "%pf64%\%browserSeaMonkey%" %cocolor% 0a
echo 13) Seamonkey
%cocolor% 0b
if exist "%pf%\%browserTorch%" %cocolor% 0a
if exist "%pf64%\%browserTorch%" %cocolor% 0a
echo 14) Torch
%cocolor% 0b
echo.
echo.
echo B) Back To Main Browser Menu
echo.
echo X) Exit This Window
echo.

set /p getInput=


if [%getInput%]==[] goto opt5

if %getInput%==B goto menuMain
if %getInput%==b goto menuMain

if %getInput%==X goto end
if %getInput%==x goto end

if %getInput% gtr 14 goto opt5

if %getInput%==1 %kill% avant.exe
if %getInput%==2 %kill% chrome.exe
if %getInput%==3 %kill% dragon.exe
if %getInput%==4 %kill% icedragon.exe
if %getInput%==5 %kill% firefox.exe
if %getInput%==6 %kill% flock.exe
if %getInput%==7 %kill% iexplore.exe
if %getInput%==8 %kill% k-meleon.exe
if %getInput%==9 %kill% Maxthon.exe
if %getInput%==10 %kill% navigator.exe
if %getInput%==11 %kill% opera.exe
if %getInput%==12 %kill% safari.exe
if %getInput%==13 %kill% seamonkey.exe
if %getInput%==14 %kill% torch.exe

goto opt5


:opt6


set getInput=999

cls
echo Select a browser to remove addons from and press ENTER:
echo.
echo.
%cocolor% 0b
if exist "%pf%\%browserAvant%" %cocolor% 0a
if exist "%pf64%\%browserAvant%" %cocolor% 0a
echo 1) Avant
%cocolor% 0b
if exist "%pf%\%browserChrome%" %cocolor% 0a
if exist "%pf64%\%browserChrome%" %cocolor% 0a
echo 2) Chrome
%cocolor% 0b
if exist "%pf%\%browserComodoDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoDragon%" %cocolor% 0a
echo 3) Comodo Dragon
%cocolor% 0b
if exist "%pf%\%browserComodoIceDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoIceDragon%" %cocolor% 0a
echo 4) Comodo Ice Dragon
%cocolor% 0b
if exist "%pf%\%browserFirefox%" %cocolor% 0a
if exist "%pf64%\%browserFirefox%" %cocolor% 0a
echo 5) Firefox
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 6) Flock
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 7) Internet Explorer
%cocolor% 0b
if exist "%pf%\%browserKmeleon%" %cocolor% 0a
if exist "%pf64%\%browserKmeleon%" %cocolor% 0a
echo 8) K-meleon
%cocolor% 0b
if exist "%pf%\%browserMaxthon%" %cocolor% 0a
if exist "%pf64%\%browserMaxthon%" %cocolor% 0a
echo 9) Maxthon
%cocolor% 0b
if exist "%pf%\%browserNetscape%" %cocolor% 0a
if exist "%pf64%\%browserNetscape%" %cocolor% 0a
echo 10) Netscape
%cocolor% 0b
if exist "%pf%\%browserOpera%" %cocolor% 0a
if exist "%pf64%\%browserOpera%" %cocolor% 0a
echo 11) Opera
%cocolor% 0b
if exist "%pf%\%browserSafari%" %cocolor% 0a
if exist "%pf64%\%browserSafari%" %cocolor% 0a
echo 12) Safari
%cocolor% 0b
if exist "%pf%\%browserSeaMonkey%" %cocolor% 0a
if exist "%pf64%\%browserSeaMonkey%" %cocolor% 0a
echo 13) Seamonkey
%cocolor% 0b
if exist "%pf%\%browserTorch%" %cocolor% 0a
if exist "%pf64%\%browserTorch%" %cocolor% 0a
echo 14) Torch
%cocolor% 0b
echo.
echo.
echo B) Back To Main Browser Menu
echo.
echo X) Exit This Window
echo.

set /p getInput=


if [%getInput%]==[] goto opt6

if %getInput%==B goto menuMain
if %getInput%==b goto menuMain

if %getInput%==X goto end
if %getInput%==x goto end

if %getInput% gtr 14 goto opt6

if %getInput%==1 goto opt6
if %getInput%==2 goto opt6
if %getInput%==3 goto opt6
if %getInput%==4 goto opt6
if %getInput%==5 goto opt6
if %getInput%==6 goto opt6
if %getInput%==7 goto opt6
if %getInput%==8 goto opt6
if %getInput%==9 goto opt6
if %getInput%==10 goto opt6
if %getInput%==11 goto opt6
if %getInput%==12 goto opt6
if %getInput%==13 goto opt6
if %getInput%==14 goto opt6

goto opt6


:opt7
set getInput=999

cls
echo Select a browser to uninstall and press ENTER:
echo.
echo.
%cocolor% 0b
if exist "%pf%\%browserAvant%" %cocolor% 0a
if exist "%pf64%\%browserAvant%" %cocolor% 0a
echo 1) Avant
%cocolor% 0b
if exist "%pf%\%browserChrome%" %cocolor% 0a
if exist "%pf64%\%browserChrome%" %cocolor% 0a
echo 2) Chrome
%cocolor% 0b
if exist "%pf%\%browserComodoDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoDragon%" %cocolor% 0a
echo 3) Comodo Dragon
%cocolor% 0b
if exist "%pf%\%browserComodoIceDragon%" %cocolor% 0a
if exist "%pf64%\%browserComodoIceDragon%" %cocolor% 0a
echo 4) Comodo Ice Dragon
%cocolor% 0b
if exist "%pf%\%browserFirefox%" %cocolor% 0a
if exist "%pf64%\%browserFirefox%" %cocolor% 0a
echo 5) Firefox
%cocolor% 0b
if exist "%pf%\%browserFlock%" %cocolor% 0a
if exist "%pf64%\%browserFlock%" %cocolor% 0a
echo 6) Flock
%cocolor% 0b
if exist "%pf%\%browserKmeleon%" %cocolor% 0a
if exist "%pf64%\%browserKmeleon%" %cocolor% 0a
echo 7) K-meleon
%cocolor% 0b
if exist "%pf%\%browserMaxthon%" %cocolor% 0a
if exist "%pf64%\%browserMaxthon%" %cocolor% 0a
echo 8) Maxthon
%cocolor% 0b
if exist "%pf%\%browserNetscape%" %cocolor% 0a
if exist "%pf64%\%browserNetscape%" %cocolor% 0a
echo 9) Netscape
%cocolor% 0b
if exist "%pf%\%browserOpera%" %cocolor% 0a
if exist "%pf64%\%browserOpera%" %cocolor% 0a
echo 10) Opera
%cocolor% 0b
if exist "%pf%\%browserSafari%" %cocolor% 0a
if exist "%pf64%\%browserSafari%" %cocolor% 0a
echo 11) Safari
%cocolor% 0b
if exist "%pf%\%browserSeaMonkey%" %cocolor% 0a
if exist "%pf64%\%browserSeaMonkey%" %cocolor% 0a
echo 12) Seamonkey
%cocolor% 0b
if exist "%pf%\%browserTorch%" %cocolor% 0a
if exist "%pf64%\%browserTorch%" %cocolor% 0a
echo 13) Torch
%cocolor% 0b
echo.
echo.
echo B) Back To Main Browser Menu
echo.
echo X) Exit This Window
echo.

set /p getInput=


if [%getInput%]==[] goto opt7

if %getInput%==B goto menuMain
if %getInput%==b goto menuMain

if %getInput%==X goto end
if %getInput%==x goto end

if %getInput% gtr 13 goto opt7

if %getInput%==1 call "%pclScriptsPath%\uninstall\browsers\avant.cmd"
if %getInput%==2 call "%pclScriptsPath%\uninstall\browsers\chrome.cmd"
if %getInput%==3 call "%pclScriptsPath%\uninstall\browsers\comodo-dragon.cmd"
if %getInput%==4 call "%pclScriptsPath%\uninstall\browsers\comodo-ice-dragon.cmd"
if %getInput%==5 call "%pclScriptsPath%\uninstall\browsers\firefox.cmd"
if %getInput%==6 call "%pclScriptsPath%\uninstall\browsers\flock.cmd"
if %getInput%==7 call "%pclScriptsPath%\uninstall\browsers\kmeleon.cmd"
if %getInput%==8 call "%pclScriptsPath%\uninstall\browsers\maxthon.cmd"
if %getInput%==9 call "%pclScriptsPath%\uninstall\browsers\netscape.cmd"
if %getInput%==10 call "%pclScriptsPath%\uninstall\browsers\opera.cmd"
if %getInput%==11 call "%pclScriptsPath%\uninstall\browsers\safari.cmd"
if %getInput%==12 call "%pclScriptsPath%\uninstall\browsers\seamonkey.cmd"
if %getInput%==13 call "%pclScriptsPath%\uninstall\browsers\torch.cmd"

goto opt7


:opt8


goto menuMain



:end

exit
