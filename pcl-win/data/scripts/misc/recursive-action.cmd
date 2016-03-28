@echo off

cls
echo ------------------------------------------------------------------------
echo WARNING!!!WARNING!!!WARNING!!!WARNING!!!WARNING!!!WARNING!!!
echo ------------------------------------------------------------------------
echo.
echo.
echo BE VERY CAUTIOUS WITH ANY COMMANDS THAT INVOLVE DELETING AND/OR REMOVING
echo FILES AND DIRECTORIES!! THIS SCRIPT DOES A FULL RECURSIVE DIRECTORY WALK
echo STARTING FROM THE FOLDER THAT THIS SCRIPT IS EXECUTED FROM!!!
echo.
echo.
echo ------------------------------------------------------------------------
echo Example: C:\Folder1\FolderA\File0.bin
echo.
echo Command is executed from "C:\Folder1"
echo.
echo Executed on "C:\Folder1", "C:\Folder1\FolderA", and target file0.bin
echo ------------------------------------------------------------------------
echo.
echo.
echo.
echo Enter a command to repeat and press ENTER:
echo.

set /p doCommand=

for /r %%a in (.) do (
cd "%%a"
echo %doCommand%>>%~dp0command-dump.txt
)
cd..