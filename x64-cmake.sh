#!/bin/bash
export OPENBLAS_COMMIT="v0.3.30-322-gef6f9762"
export MACOSX_DEPLOYMENT_TARGET=10.9


export NIGHTLY=0
export MB_ML_LIBC="manylinux"
export MB_ML_VER="2014"
export INTERFACE64=1
export BUILD_DIR="."
export PLAT="x86_64"
export OS-NAME="ubuntu-latest"
export CIBW_ARCHS=${PLAT}
export CIBW_BUILD_VERBOSITY=1
export CIBW_BUILD="cp39-${MB_ML_LIBC}_${PLAT}"
export CIBW_MANYLINUX_X86_64_IMAGE=${MB_ML_LIBC}${MB_ML_VER}

cibuildwheel "." --output-dir "dist"  > build.log 2>&1
