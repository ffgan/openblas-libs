#! /bin/bash
set -xe

if [ $(uname) == "Darwin" ]; then
    $PYTHON -m pip install delocate
    # move the mis-named scipy_openblas64-none-any.whl to a platform-specific name
    if [ "${PLAT}" == "arm64" ]; then
        for f in dist/*.whl; do mv $f "${f/%any.whl/macosx_11_0_$PLAT.whl}"; done
    else
        for f in dist/*.whl; do mv $f "${f/%any.whl/macosx_10_9_$PLAT.whl}"; done
    fi
    delocate-wheel -v dist/*.whl
else
    auditwheel repair -w dist --lib-sdir /lib dist/*.whl
    rm dist/scipy_openblas*-none-any.whl
    # Add an RPATH to libgfortran:
    # https://github.com/pypa/auditwheel/issues/451
    if [ "$MB_ML_LIBC" == "musllinux" ]; then
      apk add zip
    else
      yum install -y zip
    fi
    unzip dist/*.whl "*libgfortran*"
    patchelf --force-rpath --set-rpath '$ORIGIN' */lib/libgfortran*
    zip dist/*.whl */lib/libgfortran*
fi
