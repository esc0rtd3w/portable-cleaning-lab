@echo off


%printerSpoolerStop%
%rm% "%printerSpoolPathWild%"
%printerSpoolerStart%

:end

