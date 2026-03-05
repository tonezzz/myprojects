@echo off

REM Initialize Variables
setlocal enabledelayedexpansion
set "dir_tree="
set "file_count=0"
set "pdf_count=0"
set "xlsx_count=0"
set "docx_count=0"

REM Function to recursively parse directories
:parse_dir
for %%F in (.) do (
    echo %%~nxF
    set "dir_tree=!dir_tree!\%%~nxF"
    set /a file_count+=1
    for /r %%F %%G in (*.pdf) do (
        set /a pdf_count+=1
    )
    for /r %%F %%G in (*.xlsx) do (
        set /a xlsx_count+=1
    )
    for /r %%F %%G in (*.docx) do (
        set /a docx_count+=1
    )
)

REM Create INDEX.md File
set index_file=INDEX.md
(echo # Table of Contents
echo 
) > !index_file!
(echo ## Directory Structure
echo !dir_tree! 
) >> !index_file!
(echo ## File Statistics
echo Total Files: !file_count! 
) >> !index_file!
(echo PDF Files: !pdf_count! 
) >> !index_file!
(echo XLSX Files: !xlsx_count! 
) >> !index_file!
(echo DOCX Files: !docx_count! 
) >> !index_file!

REM Listing Detailed Information
(echo ## Detailed File Listing) >> !index_file!
for /r %%D in (*) do (
    echo - %%~nxD; >> !index_file!
)

REM Finish
endlocal