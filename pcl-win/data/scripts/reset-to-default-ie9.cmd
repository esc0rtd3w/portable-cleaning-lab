@echo off

RunDll32.exe InetCpl.cpl,ResetIEtoDefaults

RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 4351

exit