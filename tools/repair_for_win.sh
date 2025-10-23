set -xe
pip install delvewheel

if ( ${OS-NAME} == "windows-latest" ){
    # we don't need to rename the wheel for windows-latest as it have correct platform tag
    # for f in dist/*.whl; 
    #     do mv $f "${f/%any.whl/$WHEEL_PLAT.whl}";
    # done
    delvewheel repair -w $1 $2
    exit 0
}

# repair for windows arm64
./tools/repair_wheel_for_win_arm64.bat $1 $2