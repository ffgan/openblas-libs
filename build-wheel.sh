#! /bin/bash
if [[ "$NIGHTLY" = "true" ]]; then
    # Set the pyproject.toml version: convert v0.3.24-30-g138ed79f to 0.3.34.30
    version=$(cd OpenBLAS && git describe --tags --abbrev=8 | sed -e "s/^v\(.*\)-g.*/\1/" | sed -e "s/-/./g")
    sed -e "s/^version = .*/version = \"${version}\"/" -i.bak pyproject.toml
fi
if [ "macos-latest" == "${OS-NAME}" ]; then
    source tools/build_wheel.sh
else
    libc=${MB_ML_LIBC:-manylinux}
    docker_image=quay.io/pypa/${libc}${MB_ML_VER}_${PLAT}
    docker run --rm -e INTERFACE64="${INTERFACE64}" \
    -e MB_ML_LIBC="${MB_ML_LIBC}" \
    -v $(pwd):/openblas $docker_image \
    /bin/bash -xe /openblas/tools/build_wheel.sh
    sudo chmod -R a+w dist
fi