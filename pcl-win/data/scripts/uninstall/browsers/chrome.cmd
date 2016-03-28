@echo off
:: NEED TO GET INSTALLED VERSION PRIOR TO REMOVING!!!


cd "%pf%\Google\Chrome\Application\"

set version=

cd "%pf64%\Google\Chrome\Application\"

set version=


"%pf%\Google\Chrome\Application\%version%\Installer\setup.exe" --uninstall --system-level
"%pf64%\Google\Chrome\Application\%version%\Installer\setup.exe" --uninstall --system-level