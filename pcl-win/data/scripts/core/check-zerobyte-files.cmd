@echo off



:: Check 0-byte files
if %targetFile%==0 goto end


for %%a in ("%targetFile%") do (
  if %%~za equ 0 (
	echo 1>"%pclTempTemp%\zeroByteFile.check"
  ) else (
	echo 0>"%pclTempTemp%\zeroByteFile.check"
    goto end
  )
)

if exist "%pclTempTemp%\zeroByteFile.check" set /p zeroByteFile=<"%pclTempTemp%\zeroByteFile.check"

:end
