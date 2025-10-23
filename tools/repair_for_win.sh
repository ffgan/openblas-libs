
if [[ ${OS-NAME} == "windows-latest" ]];then
    # we don't need to rename the wheel for windows-latest as it have correct platform tag
    # for f in dist/*.whl; 
    #     do mv $f "${f/%any.whl/$WHEEL_PLAT.whl}";
    # done
    exit 0
fi

# test for windows arm64
./tools/repair_wheel_for_win_arm64.bat