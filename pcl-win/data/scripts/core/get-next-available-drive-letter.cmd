@echo off


setlocal enableDelayedExpansion
set "pclModuleTempLetter=DEFGHIJKLMNOPQRSTUVWXYZ"
for /f "delims=:" %%a in ('wmic logicaldisk get caption') do set "pclModuleTempLetter=!pclModuleTempLetter:%%a=!"
echo %pclModuleTempLetter:~0,1%>"%pclTempMain%\pclModuleTempDriveLetter.tmp"
endlocal



:end