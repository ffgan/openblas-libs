#!/bin/bash
set -ex


# install-rtools
# rtools 42+ does not support 32 bits builds.
choco install -y rtools --no-progress --force --version=4.0.0.20220206


# Build
git submodule update --init --recursive
& $env:BASH_PATH -lc tools/build_openblas.sh


# Test
& $env:BASH_PATH -lc tools/build_gfortran.sh
echo "Static test"
.\for_test\test.exe
echo "Dynamic test"
.\for_test\test_dyn.exe

# Copy
cp for_test\test*.exe builds