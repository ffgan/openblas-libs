if "%if_bits%"=="32" (
    move /Y pyproject.toml.bak pyproject.toml
    move /Y "%CD%\ob64_backup" "%ob_64%"
)

:: Rename the wheel
for %%f in (dist\*any.whl) do (
    set WHEEL_FILE=dist\%%f
    set "filename=%%~nxf"
    set "newname=!filename:any.whl=win_arm64.whl!"
    ren "dist\!filename!" "!newname!"
)