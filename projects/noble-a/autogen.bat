@echo off

setlocal enabledelayedexpansion

REM Enhanced recursive subdirectory scanning and detailed file information generation

set "root_dir=%cd%"

echo Scanning directories in: !root_dir!

echo ---------------------------------------

REM Get a list of all files in the current directory and subdirectories
for /r %%f in (*) do (
    echo File: %%f
    echo Size: %%~zf bytes
    echo Last Modified: %%~tf
    echo ---------------------------------------
)

pause
