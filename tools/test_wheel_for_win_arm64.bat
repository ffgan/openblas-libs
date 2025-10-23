:: Locate the built wheel
for /f %%f in ('dir /b dist\scipy_openblas*.whl 2^>nul') do set WHEEL_FILE=dist\%%f

if not defined WHEEL_FILE (
    echo Error: No wheel file found in dist folder.
    exit /b 1
)
 
echo Installing wheel: %WHEEL_FILE%
pip install "%WHEEL_FILE%"
if errorlevel 1 exit /b 1
 
echo Done.
exit /b 0
