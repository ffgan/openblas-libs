git submodule update --init --recursive

if "${OS-NAME}" -eq "windows-latest" {
    # Build
    & $env:BASH_PATH -lc tools/build_openblas.sh


    # Test
    & $env:BASH_PATH -lc tools/build_gfortran.sh
    echo "Static test"
    .\for_test\test.exe
    echo "Dynamic test"
    .\for_test\test_dyn.exe

    # Copy
    cp for_test\test*.exe builds
    exit 0
}

# below for windows-11-arm
.\tools\build_steps_win_arm64.bat 64 ${env:INTERFACE_BITS}
