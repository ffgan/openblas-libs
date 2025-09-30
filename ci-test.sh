#!/bin/bash
# Test that the wheel works with a different python
set -xe

if [ "${PLAT}" == "arm64" ]; then
    # Cannot test
    exit 0
fi

PYTHON=python3.11
if [ "$(uname)" == "Darwin" -a "${PLAT}" == "x86_64" ]; then
    which python3.11
    PYTHON="arch -x86_64 python3.11"
fi
if [ "${INTERFACE64}" != "1" ]; then
  $PYTHON -m pip install --no-index --find-links dist scipy_openblas32
  $PYTHON -m scipy_openblas32
else
  $PYTHON -m pip install --no-index --find-links dist scipy_openblas64
  $PYTHON -m scipy_openblas64
fi
