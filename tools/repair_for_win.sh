
if [[ ${OS-NAME} == "windows-latest" ]];then
    for f in dist/*.whl; 
        do mv $f "${f/%any.whl/$WHEEL_PLAT.whl}";
    done
    exit 0
fi

# test for windows arm64
./tools/repair_wheel_for_win_arm64.bat