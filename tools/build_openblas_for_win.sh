set -xe
git submodule update --init --recursive

if [[ ${env:OS-NAME} -eq "windows-latest" ]]; then
    # Build
    $BASH_PATH tools/build_openblas.sh

    # Test
    $BASH_PATH tools/build_gfortran.sh
    echo "Static test"
    .\for_test\test.exe
    echo "Dynamic test"
    .\for_test\test_dyn.exe

    # Copy
    cp for_test\test*.exe builds

    $BASH_PATH tools/build_wheel_prepare_for_win.sh
    exit 0
fi

# below for windows-11-arm
.\tools\build_steps_win_arm64.bat 64 ${env:INTERFACE_BITS}
