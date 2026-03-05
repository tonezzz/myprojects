@echo off
REM ============================================
REM Generate INDEX.md with subdirectory support
REM ============================================

setlocal enabledelayedexpansion

REM Set the target folder path
set FOLDER_PATH=.
set OUTPUT_FILE=%FOLDER_PATH%\INDEX.md

REM Create the header
(
    echo # Receipt Income Files - Index
    echo.
    echo Generated: %date% %time%
    echo.
    echo ## Files and Folders
    echo.
) > "%OUTPUT_FILE%"

REM Counter variables
set /a TOTAL_FILES=0
set /a TOTAL_FOLDERS=0

REM Process root level files first
if exist "%FOLDER_PATH%\*.pdf" (
    echo ### Root Folder
    echo.
    for %%F in ("%FOLDER_PATH%\*.pdf") do (
        echo - %%~nxF >> "%OUTPUT_FILE%"
        set /a TOTAL_FILES+=1
    )
    echo. >> "%OUTPUT_FILE%"
)

REM Process subdirectories
for /d %%D in ("%FOLDER_PATH%\*") do (
    set /a TOTAL_FOLDERS+=1
    set SUBFOLDER_NAME=%%~nxD
    
    echo ### Subfolder: !SUBFOLDER_NAME! >> "%OUTPUT_FILE%"
    echo. >> "%OUTPUT_FILE%"
    
    REM List all files in subdirectory (all types)
    if exist "%%D\*.*" (
        for %%F in ("%%D\*.*") do (
            echo - %%~nxF >> "%OUTPUT_FILE%"
            set /a TOTAL_FILES+=1
        )
    ) else (
        echo (empty folder) >> "%OUTPUT_FILE%"
    )
    
    echo. >> "%OUTPUT_FILE%"
)

REM Add summary
(
    echo ## Summary
    echo - Total Files: !TOTAL_FILES!
    echo - Total Subfolders: !TOTAL_FOLDERS!
    echo - Last Updated: %date% %time%
) >> "%OUTPUT_FILE%"

echo.
echo ✓ INDEX.md created successfully!
echo Location: %OUTPUT_FILE%
echo Files scanned: !TOTAL_FILES!
echo Subfolders found: !TOTAL_FOLDERS!
echo.
pause
