#! /bin/bash
set -xeo pipefail
source tools/build_steps.sh
echo "------ BEFORE BUILD ---------"
before_build
if [[ "$NIGHTLY" = "true" ]]; then
    echo "------ CLEAN CODE --------"
    clean_code $REPO_DIR develop
    echo "------ BUILD LIB --------"
    build_lib "$PLAT" "$INTERFACE64" "1"
else
    echo "------ CLEAN CODE --------"
    clean_code $REPO_DIR $OPENBLAS_COMMIT
    echo "------ BUILD LIB --------"
    build_lib "$PLAT" "$INTERFACE64" "0"
fi