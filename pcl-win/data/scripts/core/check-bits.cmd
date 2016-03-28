@echo off


set bits=x86

if not exist "C:\Program Files (x86)" set bits=x86
if exist "C:\Program Files (x86)" set bits=x64
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set bits=x64
